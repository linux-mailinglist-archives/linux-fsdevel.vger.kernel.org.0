Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D892D59A364
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 20:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349740AbiHSR4T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 13:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352398AbiHSRzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:55:45 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5107BD4FC;
        Fri, 19 Aug 2022 10:37:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x21so6498717edd.3;
        Fri, 19 Aug 2022 10:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kc3OXexcLg160QlZiu+v0UTRCRGI9Oo6HVQoGkcLTv4=;
        b=ObyltFHH8+KwonRV7aekpXmDL7MboFnhrIvq31WMDBatt640xT8ozhUnEtsHpmWelB
         jjYDSppixzDtrn9T1Xi+utbiV49O/k55trn7A5FD/7Nnq7KFs9/27Pmr1+QJl9wWq3lr
         Lv4aXii8H/LuP3A8PG8bqUIbeYrLTWPOaQ2kzyuX5k7ph1/p79fNwIfSjPVzFoC0l1Br
         0dGr93K/h/DR7PBl86YKv6Z1VmUVJN/yEjtbi1EcrCNVsLeQGgwreYT9lT/iot6MmI9O
         SSsBNUOwVjYboWuQw75Vnw+KigIH/PDvzJy/lGxzirNALGOiKHdKiZQ5CgSegNyoEG6x
         pn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kc3OXexcLg160QlZiu+v0UTRCRGI9Oo6HVQoGkcLTv4=;
        b=uBpE4PtiH4t9/1Y97+mX1DJdjKvlQ6NrKbYC0TnvgWZm6YstmTxAhMGrU3yGQraYCF
         5XlRmfhPdv7S5wpXtTZTnn4UW9cxsbqu7wUDJETR1LfTkD3yW1CL9DDANu3CY5E02w+8
         W8NqtqNAth7XnixA7xy28GoCDBBox9Y1SqCoIxLMn0GUDh+uzSjdFrMmfbC8Hr7eZwfd
         S2+AOZK+ryGcMqeGS5HkOslrU7PeHuUSI2NSx0t19IqvZCbGZMhNxPKnGxUi3aEZTniE
         HvkyEwwc0YvGrIpAILnUqV5K1QxhdibfjiiBsQmV5b+yLceC0yBSaibdKiwXtu60diuq
         oNyA==
X-Gm-Message-State: ACgBeo13EP2zxXuC+H0OetGexlGlUahUN+tHwa9kNm9pr8dvSv9ypgA+
        4T1trTi3eiUF87Hkrkf0KDDt5pWLCTo/AG+oeVM=
X-Google-Smtp-Source: AA6agR4fUxhX89XbFo3bNQH2+ZJspjFuNMP7tIoqYe66vsrPDhSy02r29F1Up3ZEmnDDUtifIhqg9V7UX8BQ/XFy8Jo=
X-Received: by 2002:a05:6402:40c2:b0:440:4ecd:f75f with SMTP id
 z2-20020a05640240c200b004404ecdf75fmr6813062edb.405.1660930664439; Fri, 19
 Aug 2022 10:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <Yv1jwsHVWI+lguAT@ZenIV> <CAN-5tyFvV7QOxyAQXu3UM5swQVB2roDpQ5CBRVc64Epp1gj9hg@mail.gmail.com>
 <Yv2BVKuzZdMDY2Td@ZenIV> <CAN-5tyF0ZMX8a6M6Qbbco3EmOzwVnnGZmqak8=t4Cvtzc45g7Q@mail.gmail.com>
 <CAOQ4uxgA8jD6KnbuHDevNLsjD-LbEs_y1W6uYMEY6EG_es0o+Q@mail.gmail.com>
 <Yv3Ti/niVd5ZVPP+@ZenIV> <CAN-5tyHpDHzmo-rSw1X+0oX0xbxR+x13eP57osB0qhFLKbXzVA@mail.gmail.com>
 <b7a77d4f-32de-af24-ed5c-8a3e49947c5a@oracle.com> <CAN-5tyH6=GD_A48PEu0oWZYix4g0=+0FwVgE262Ek0U1qNiwvA@mail.gmail.com>
 <debe59b1-35cc-c3b0-f3ca-76d6a56b826b@oracle.com>
In-Reply-To: <debe59b1-35cc-c3b0-f3ca-76d6a56b826b@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 19 Aug 2022 13:37:33 -0400
Message-ID: <CAN-5tyHdr_RXPcFpa7fsg=jpOyge0C4pB1waj=BdHHzmeaMdPw@mail.gmail.com>
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

On Fri, Aug 19, 2022 at 11:42 AM <dai.ngo@oracle.com> wrote:
>
>
> On 8/19/22 7:22 AM, Olga Kornievskaia wrote:
> > On Thu, Aug 18, 2022 at 10:52 PM <dai.ngo@oracle.com> wrote:
> >>
> >> On 8/18/22 6:13 AM, Olga Kornievskaia wrote:
> >>> On Thu, Aug 18, 2022 at 1:52 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >>>> On Thu, Aug 18, 2022 at 08:19:54AM +0300, Amir Goldstein wrote:
> >>>>
> >>>>> NFS spec does not guarantee the safety of the server.
> >>>>> It's like saying that the Law makes Crime impossible.
> >>>>> The law needs to be enforced, so if server gets a request
> >>>>> to COPY from/to an fhandle that resolves as a non-regular file
> >>>>> (from a rogue or buggy NFS client) the server should return an
> >>>>> error and not continue to alloc_file_pseudo().
> >>>> FWIW, my preference would be to have alloc_file_pseudo() reject
> >>>> directory inodes if it ever gets such.
> >>>>
> >>>> I'm still not sure that my (and yours, apparently) interpretation
> >>>> of what Olga said is correct, though.
> >>> Would it be appropriate to do the following then:
> >>>
> >>> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> >>> index e88f6b18445e..112134b6438d 100644
> >>> --- a/fs/nfs/nfs4file.c
> >>> +++ b/fs/nfs/nfs4file.c
> >>> @@ -340,6 +340,11 @@ static struct file *__nfs42_ssc_open(struct
> >>> vfsmount *ss_mnt,
> >>>                   goto out;
> >>>           }
> >>>
> >>> +       if (S_ISDIR(fattr->mode)) {
> >>> +               res = ERR_PTR(-EBADF);
> >>> +               goto out;
> >>> +       }
> >>> +
> >> Can we also enhance nfsd4_do_async_copy to check for
> >> -EBADF and returns nfserr_wrong_type? perhaps adding
> >> an error mapping function to handle other errors also.
> > On the server side, if the open fails that's already translated into
> > the appropriate error -- err_off_load_denied.
>
> Currently the server returns nfserr_offload_denied if the open
> fails for any reasons. I'm wondering whether the server should
> return more accurate error code such as if the source file handle
> is a wrong type then the server should return nfserr_wrong_type,
> instead of nfserr_offload_denied, to match the spec:
>
>     Both SAVED_FH and CURRENT_FH must be regular files.  If either
>     SAVED_FH or CURRENT_FH is not a regular file, the operation MUST fail
>     and return NFS4ERR_WRONG_TYPE.

Ok sure. That's a relevant but a separate patch.

>
> -Dai
>
> >
> >> -Dai
> >>
> >>>           res = ERR_PTR(-ENOMEM);
> >>>           len = strlen(SSC_READ_NAME_BODY) + 16;
> >>>           read_name = kzalloc(len, GFP_KERNEL);
> >>> @@ -357,6 +362,7 @@ static struct file *__nfs42_ssc_open(struct
> >>> vfsmount *ss_mnt,
> >>>                                        r_ino->i_fop);
> >>>           if (IS_ERR(filep)) {
> >>>                   res = ERR_CAST(filep);
> >>> +               iput(r_ino);
> >>>                   goto out_free_name;
> >>>           }
