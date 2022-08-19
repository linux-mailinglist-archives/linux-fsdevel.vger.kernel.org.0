Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D939599D7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 16:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349138AbiHSOXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 10:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349063AbiHSOXA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:23:00 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4834B72AD;
        Fri, 19 Aug 2022 07:22:59 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o22so5849453edc.10;
        Fri, 19 Aug 2022 07:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8zqquuEhRDjH7nVxfkiuZtn7Lef0I4tXNA1l6b9ya6o=;
        b=iLHo4LaY1kzm0o7kBmnrS8yDYyw2qP/D+rp1lTFyInUum4NCRybh77J7clt7cjgusG
         nBl4FZ0p37ZWjsef9YjmMxlWN/TlPmRZT721R38ikRGJYd+0q2ovLnJONK9Xpi1i2k8l
         yMvlIBWLqUF40hz0wsB3glHxNDSKbgrnVYzWQ8rAYjkrcVBI5YH57v0Cp2rBBTm0u6K5
         46QoSc/E9zRiALAFaK3V+vLrbkrz/F/55HqNN42G9u8h/pPA/NSal9O+G1oDpWL4oxyQ
         aQ7oHvESpDlk7Z6nKzyH2Z0na6NC/umcvc3U1PLobDqts0s3WD2jpo8dfZQZkNMx2FcU
         huNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8zqquuEhRDjH7nVxfkiuZtn7Lef0I4tXNA1l6b9ya6o=;
        b=ToMGnCxkB9Cq911GqB4SkrEc//jPra5yPw1vsdofbyz1eerKHf8/HzmoRMPhcUEWAD
         Mzc2fsaPCJZXjjWliurex2KaJBM9ZNDO6GrxmrJfVkNNGvS6HSzEWsbBvH92DaMGEWVy
         X97/dO/sAxJH3usDRbplkKJSN6jq2aMMmPFt9anGTb8hZ6Ac7fA/dO2XUmmx4axNKWsM
         1DzgBIx5bUGLaExmzn9o+X5RRx82X1npV6RxGPC0TDUj7RUffBDBzCU4hpze8f8EgpHp
         CpvC1bmCimc8lPkfKSp/BPUdHhZk+U15htat2bG/x7gFYivFiSVgJBhgOZxDVPaFfzsH
         fPuQ==
X-Gm-Message-State: ACgBeo1ZG77lSzbcl6/p+CGInC1NxOCNALTTx2NCKaE+XEmW5frhVHY+
        vQZVAFmSO+GWtIjxno6bYfo+UdDEHR/PZoFvm0k=
X-Google-Smtp-Source: AA6agR6Jcp3qkzZYqL5OK6PsDB3dPWUpbjXAJDxsOGELdbaX0NxjcKmosxSf5SSDP8O364sJNaP6syo+5QvJLWoGLsw=
X-Received: by 2002:a05:6402:40c2:b0:440:4ecd:f75f with SMTP id
 z2-20020a05640240c200b004404ecdf75fmr6219384edb.405.1660918978362; Fri, 19
 Aug 2022 07:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <Yv1jwsHVWI+lguAT@ZenIV> <CAN-5tyFvV7QOxyAQXu3UM5swQVB2roDpQ5CBRVc64Epp1gj9hg@mail.gmail.com>
 <Yv2BVKuzZdMDY2Td@ZenIV> <CAN-5tyF0ZMX8a6M6Qbbco3EmOzwVnnGZmqak8=t4Cvtzc45g7Q@mail.gmail.com>
 <CAOQ4uxgA8jD6KnbuHDevNLsjD-LbEs_y1W6uYMEY6EG_es0o+Q@mail.gmail.com>
 <Yv3Ti/niVd5ZVPP+@ZenIV> <CAN-5tyHpDHzmo-rSw1X+0oX0xbxR+x13eP57osB0qhFLKbXzVA@mail.gmail.com>
 <b7a77d4f-32de-af24-ed5c-8a3e49947c5a@oracle.com>
In-Reply-To: <b7a77d4f-32de-af24-ed5c-8a3e49947c5a@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 19 Aug 2022 10:22:46 -0400
Message-ID: <CAN-5tyH6=GD_A48PEu0oWZYix4g0=+0FwVgE262Ek0U1qNiwvA@mail.gmail.com>
Subject: Re: [RFC] problems with alloc_file_pseudo() use in __nfs42_ssc_open()
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 18, 2022 at 10:52 PM <dai.ngo@oracle.com> wrote:
>
>
> On 8/18/22 6:13 AM, Olga Kornievskaia wrote:
> > On Thu, Aug 18, 2022 at 1:52 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >> On Thu, Aug 18, 2022 at 08:19:54AM +0300, Amir Goldstein wrote:
> >>
> >>> NFS spec does not guarantee the safety of the server.
> >>> It's like saying that the Law makes Crime impossible.
> >>> The law needs to be enforced, so if server gets a request
> >>> to COPY from/to an fhandle that resolves as a non-regular file
> >>> (from a rogue or buggy NFS client) the server should return an
> >>> error and not continue to alloc_file_pseudo().
> >> FWIW, my preference would be to have alloc_file_pseudo() reject
> >> directory inodes if it ever gets such.
> >>
> >> I'm still not sure that my (and yours, apparently) interpretation
> >> of what Olga said is correct, though.
> > Would it be appropriate to do the following then:
> >
> > diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> > index e88f6b18445e..112134b6438d 100644
> > --- a/fs/nfs/nfs4file.c
> > +++ b/fs/nfs/nfs4file.c
> > @@ -340,6 +340,11 @@ static struct file *__nfs42_ssc_open(struct
> > vfsmount *ss_mnt,
> >                  goto out;
> >          }
> >
> > +       if (S_ISDIR(fattr->mode)) {
> > +               res = ERR_PTR(-EBADF);
> > +               goto out;
> > +       }
> > +
>
> Can we also enhance nfsd4_do_async_copy to check for
> -EBADF and returns nfserr_wrong_type? perhaps adding
> an error mapping function to handle other errors also.

On the server side, if the open fails that's already translated into
the appropriate error -- err_off_load_denied.

>
> -Dai
>
> >          res = ERR_PTR(-ENOMEM);
> >          len = strlen(SSC_READ_NAME_BODY) + 16;
> >          read_name = kzalloc(len, GFP_KERNEL);
> > @@ -357,6 +362,7 @@ static struct file *__nfs42_ssc_open(struct
> > vfsmount *ss_mnt,
> >                                       r_ino->i_fop);
> >          if (IS_ERR(filep)) {
> >                  res = ERR_CAST(filep);
> > +               iput(r_ino);
> >                  goto out_free_name;
> >          }
