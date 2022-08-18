Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2B35983E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 15:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244967AbiHRNOx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 09:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244902AbiHRNON (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:14:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B45BB07C4;
        Thu, 18 Aug 2022 06:14:12 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b16so1850005edd.4;
        Thu, 18 Aug 2022 06:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mZv/c/CYuSR3duCVHjliuPbUfyHoY0t1CGzPM20CZ5U=;
        b=e+w8CCi7vv6jDnqBYja5OtJr+HCM2Qt5oefyX0NRldj83jcC9Jiurpz0OmGHDfdWyB
         97iGafnk6rsqDz08Je+ivbbh91dleHU016LbDEyUxKgVPDRnrmdhG0TUoxzB59dBfclx
         a1CCBepPUDZnFrBboqj9cDdILMHgyp+el3BBeYA/9K5ggOZL5hAg0MImEdRF5WXLA+oW
         /ac4Rmllc8TQa4Ky7cFrQRvMsGzsb8lcI6o7FH/6d+bwaf1jGbHEEBg6sdSTecI5scJP
         CCUltPFshBeESFMoHkaWwq0rrmCTZrrU7JSoDo9H4f4RYBQnQn9lhKPPbRDuT6pfa897
         /6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mZv/c/CYuSR3duCVHjliuPbUfyHoY0t1CGzPM20CZ5U=;
        b=bNnFMfhLos5dFgBTUZMdyutROcRnnrva2Vvo7cwmwH6T5tFx5lNu+oKEA6mmhnpQ8V
         ieoWJOpcTJ0imf/A1wjlz4QjCYN/eyIjr5U+L8Cq5kc1n6r7IpUQbkc3O0Z1tsP5DJpE
         nrleaDDnQeSTD0PrPvZ7PRXg34V4N+NNmyGV9BjWi4kE9b0aKNinEBJESHnAgD/WJPog
         qX7pM9kAUbtUIEu+LiRm+B33j5MC+6DEWgPFPd23v04Pai61dtPiAh2arof25HdD2ylb
         pPNcRoA8gwmvs7vs5jyBVioMBk6hySGcHURQEeqINceml4793WY2Q+ai5z8f2Bdfx4gB
         Mk8Q==
X-Gm-Message-State: ACgBeo1+A55tja/QiLPuVKDagslB+K4+0hf2AguXcZgYriS1kSVZtpcR
        c9H8oTmS5mAVq4xes9nCsw6Z5flLkJi34Wy2y80+W5KCvZ0=
X-Google-Smtp-Source: AA6agR696XN10f+evoLioeunky7Is736k1nRWBS3H25M16EJYYyDL+FwaYrpv13tvt0n+jtYXkEQF4W9L/36oF3I9nI=
X-Received: by 2002:a05:6402:5216:b0:43e:81c5:82dd with SMTP id
 s22-20020a056402521600b0043e81c582ddmr2232190edd.345.1660828450353; Thu, 18
 Aug 2022 06:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <Yv1jwsHVWI+lguAT@ZenIV> <CAN-5tyFvV7QOxyAQXu3UM5swQVB2roDpQ5CBRVc64Epp1gj9hg@mail.gmail.com>
 <Yv2BVKuzZdMDY2Td@ZenIV> <CAN-5tyF0ZMX8a6M6Qbbco3EmOzwVnnGZmqak8=t4Cvtzc45g7Q@mail.gmail.com>
 <CAOQ4uxgA8jD6KnbuHDevNLsjD-LbEs_y1W6uYMEY6EG_es0o+Q@mail.gmail.com> <Yv3Ti/niVd5ZVPP+@ZenIV>
In-Reply-To: <Yv3Ti/niVd5ZVPP+@ZenIV>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 18 Aug 2022 09:13:59 -0400
Message-ID: <CAN-5tyHpDHzmo-rSw1X+0oX0xbxR+x13eP57osB0qhFLKbXzVA@mail.gmail.com>
Subject: Re: [RFC] problems with alloc_file_pseudo() use in __nfs42_ssc_open()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 18, 2022 at 1:52 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Aug 18, 2022 at 08:19:54AM +0300, Amir Goldstein wrote:
>
> > NFS spec does not guarantee the safety of the server.
> > It's like saying that the Law makes Crime impossible.
> > The law needs to be enforced, so if server gets a request
> > to COPY from/to an fhandle that resolves as a non-regular file
> > (from a rogue or buggy NFS client) the server should return an
> > error and not continue to alloc_file_pseudo().
>
> FWIW, my preference would be to have alloc_file_pseudo() reject
> directory inodes if it ever gets such.
>
> I'm still not sure that my (and yours, apparently) interpretation
> of what Olga said is correct, though.

Would it be appropriate to do the following then:

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index e88f6b18445e..112134b6438d 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -340,6 +340,11 @@ static struct file *__nfs42_ssc_open(struct
vfsmount *ss_mnt,
                goto out;
        }

+       if (S_ISDIR(fattr->mode)) {
+               res = ERR_PTR(-EBADF);
+               goto out;
+       }
+
        res = ERR_PTR(-ENOMEM);
        len = strlen(SSC_READ_NAME_BODY) + 16;
        read_name = kzalloc(len, GFP_KERNEL);
@@ -357,6 +362,7 @@ static struct file *__nfs42_ssc_open(struct
vfsmount *ss_mnt,
                                     r_ino->i_fop);
        if (IS_ERR(filep)) {
                res = ERR_CAST(filep);
+               iput(r_ino);
                goto out_free_name;
        }
