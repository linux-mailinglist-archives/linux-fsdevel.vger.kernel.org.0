Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3675597DFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 07:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241334AbiHRFUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 01:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239419AbiHRFUI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 01:20:08 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CDA74DE4;
        Wed, 17 Aug 2022 22:20:06 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id k2so464650vsk.8;
        Wed, 17 Aug 2022 22:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5u39g6enjL3TnhMx1SP5kr0OpbGZJ2krVZeHPYNVV2g=;
        b=bcGhUZfCKUpACpTP3USFIBUCGNtRGJgas//fOWlAq6d7WgJlvtYC0VxdZt0g00/RJ4
         ZEXua8tkx/bIZNkeVnnxHWhCM3U4k5S/lDG9dpYv61EepruAlQVF1Ami8Y238RlTXArR
         EPY9cFDfko9TZnfaCv37LeckaD2GjxeL7LV9i6B7SmiOkzTG8TRx3igH7SjqlhN0iIkh
         yAYfRxswYM7+A3bQYsdIe/qyguMxjxDEcrK0/paiI6XvAhQCfkRAxsgBAQTJLCWzzSsX
         xFDujOXZvgQXBOF0aeGL5WAHRXOF6oQbrIreOcyldnieUxsr1U5DTvRQCTmpAsvprcOX
         vPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5u39g6enjL3TnhMx1SP5kr0OpbGZJ2krVZeHPYNVV2g=;
        b=p/IFMP4ReTGhlJZXDR/gDMBDK526Dqi6KE4hmH8KFbUHOQLMY8Hv77s+xY3DbnR9L9
         dSMStn/WhBgRwUvlqjLr0DbWMos1GYKdcUI0z1UbRMGt0+2+DKjASnAl+XLW0OH/mhox
         heGXLtpJtqtOj1PvuJDBIQdc8iDpVCBeAdAQqH4qu4k1XzNNzAMDqo/je48iLHyzdmT7
         Rcj21UxUlN+owDcWIdTRuX5xgUMmESnUemGjAS8SHtM+T6qZGC5B0pvMVtYgdhR3tTog
         5TYi7U/2sFbpqAjBI3as8wNGI0+3kMD3bhCVKNu4q06RIn2usO4Ue2VHtSbJT7j4GRg1
         f3eQ==
X-Gm-Message-State: ACgBeo0O61BCv2dzV02GPsOFah/3skbkEPYkKGo7i/kQiea5Tm22IV5w
        hsWGTUOgGV05S9oBZNptIRYqK3yuzg1aKWSRg7s=
X-Google-Smtp-Source: AA6agR6BhSrv9VHjUNG2L+DsTl3V2UVGb/bUIhtHawKstOSbcUAHR1+DqJGiFfmXQWeZNN685pcFYOgZx0+Js1zereI=
X-Received: by 2002:a67:a246:0:b0:38c:9563:d2d8 with SMTP id
 t6-20020a67a246000000b0038c9563d2d8mr580410vsh.2.1660800005916; Wed, 17 Aug
 2022 22:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <Yv1jwsHVWI+lguAT@ZenIV> <CAN-5tyFvV7QOxyAQXu3UM5swQVB2roDpQ5CBRVc64Epp1gj9hg@mail.gmail.com>
 <Yv2BVKuzZdMDY2Td@ZenIV> <CAN-5tyF0ZMX8a6M6Qbbco3EmOzwVnnGZmqak8=t4Cvtzc45g7Q@mail.gmail.com>
In-Reply-To: <CAN-5tyF0ZMX8a6M6Qbbco3EmOzwVnnGZmqak8=t4Cvtzc45g7Q@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 18 Aug 2022 08:19:54 +0300
Message-ID: <CAOQ4uxgA8jD6KnbuHDevNLsjD-LbEs_y1W6uYMEY6EG_es0o+Q@mail.gmail.com>
Subject: Re: [RFC] problems with alloc_file_pseudo() use in __nfs42_ssc_open()
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 18, 2022 at 3:23 AM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> On Wed, Aug 17, 2022 at 8:01 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Wed, Aug 17, 2022 at 06:32:15PM -0400, Olga Kornievskaia wrote:
> > > On Wed, Aug 17, 2022 at 6:18 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > >
> > > >         My apologies for having missed that back when the SSC
> > > > patchset had been done (and missing the problems after it got
> > > > merged, actually).
> > > >
> > > > 1) if this
> > > >         r_ino = nfs_fhget(ss_mnt->mnt_sb, src_fh, fattr);
> > > > in __nfs42_ssc_open() yields a directory inode, we are screwed
> > > > as soon as it's passed to alloc_file_pseudo() - a *lot* of places
> > > > in dcache handling would break if we do that.  It's not too
> > > > nice for a regular file from non-cooperating filesystem, but for
> > > > directory ones it's deadly.
> > >
> > > This inode is created to make an appearance of an opened file to do
> > > (an NFS) read, it's never a directory.
> >
> > Er...  Where does the fhandle come from?  From my reading it's a client-sent
> > data; I don't know what trust model do you assume, but the price of
> > getting multiple dentries over the same directory inode is high.
> > Bogus or compromised client should not be able to cause severe corruption
> > of kernel data structures...
>
> This is an NFS spec specified operation. The (source file's)
> filehandle comes from the COPY operation compound that the destination
> server gets and then uses -- creates an inode from using the code you
> are looking at now -- to access from the source server. Security is
> all described in the spec. The uniqueness of the filehandle is
> provided by the source server that created it.

Olga,

NFS spec does not guarantee the safety of the server.
It's like saying that the Law makes Crime impossible.
The law needs to be enforced, so if server gets a request
to COPY from/to an fhandle that resolves as a non-regular file
(from a rogue or buggy NFS client) the server should return an
error and not continue to alloc_file_pseudo().

Thanks,
Amir.
