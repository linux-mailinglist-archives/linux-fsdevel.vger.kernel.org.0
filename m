Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D542969BAF9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 17:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBRQYc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Feb 2023 11:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBRQYb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Feb 2023 11:24:31 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5BB2D78;
        Sat, 18 Feb 2023 08:24:30 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id c12so941568wrx.12;
        Sat, 18 Feb 2023 08:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nNG/ZkOCIrrfrgO8M6bqZE57VLyTtK7ATZ3OMgUqmyA=;
        b=SopmrsAD92rtqJgzUbDjMoG/uvyDq05yQOviGlTdjGdHdGw/vno8LqBLWm6hacs0Ys
         FI/eAQNM1rpK2yh9uniWFbJiVTw+MOI/07Btn1TALCpmoAymBUhBmB+l5+wkzvkVznoN
         KaxDGgs8YVFrsHkL2ugCuUYSlfc84ViA11PhyrlIAysK3tJZrjAR6SfnbZUVTQHKGGhQ
         jriTfdvlzLvUzlbokfsvKuz7gAoc6OwKp5fLWCE1xhmpqp9eOdGhE3eg9MWf6JQpOuAj
         zvf24okaPnMjgQ0MUmmvMJ1ZSqItPeDi/g2Dz1Dfjs30G/2ICD9CMMaUZfJWOEjx4yCE
         YUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNG/ZkOCIrrfrgO8M6bqZE57VLyTtK7ATZ3OMgUqmyA=;
        b=eDq0KVVOIOKGrFK6mweKPsHONst6ZNqYTDXJZ0R8o2hqsi0P64fmfnKsUVYWlqAb8s
         S+NhLBPymKr7hW53EgDNh4a7js5Dvskbpimq6HuUJXCRgVCt3J2pACL5rInFRXSIbHLB
         bBpqAtgTPB+DogyMsLZGP4WAcEucMWQRCy//hTeAdglsHKd18yehMoZlcdVa3OLNTsh8
         ZcxJI9a+XqKSeTsG3wy2RMdEFBVUMtUUxGCDLqzbKplw6u3j88kUmtQ+osS/0q8+fI9m
         L+NwTgD6Jcu1T/7/WaB1UyNKrrAQ7VUC2C4U8HEvk2H/kx1QC8xcuVjDuEPBmsjFE5mw
         Sbvw==
X-Gm-Message-State: AO0yUKXuEQdPFas+ZDxlknzHjSvOjrOvZmbimycrivO6KzGr6NTddbdt
        PYoP10dG5bjHsk8VYk2NtUlevlXmC7ZiEj5DMPE=
X-Google-Smtp-Source: AK7set+IJQedZgNv3Xg8eCsBCe8oByqYF768XCrPeeTCvF0MpLXSOAbCa6NGgA6L59XPm2UqqDvTyj06v0wWeXkvT60=
X-Received: by 2002:a5d:6e8a:0:b0:2c5:50db:e9fc with SMTP id
 k10-20020a5d6e8a000000b002c550dbe9fcmr46111wrz.674.1676737468580; Sat, 18 Feb
 2023 08:24:28 -0800 (PST)
MIME-Version: 1.0
References: <20230124023834.106339-1-ericvh@kernel.org> <20230218003323.2322580-1-ericvh@kernel.org>
 <20230218003323.2322580-5-ericvh@kernel.org> <Y/CbhQVeO8/pxrBE@codewreck.org>
In-Reply-To: <Y/CbhQVeO8/pxrBE@codewreck.org>
From:   Eric Van Hensbergen <ericvh@gmail.com>
Date:   Sat, 18 Feb 2023 10:24:17 -0600
Message-ID: <CAFkjPTmBs10YAPrXYx3hQHvVu0P3+_fJ+_eZ+9z6h7csSqRYbw@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] fs/9p: Remove unnecessary superblock flags
To:     asmadeus@codewreck.org
Cc:     Eric Van Hensbergen <ericvh@kernel.org>,
        v9fs-developer@lists.sourceforge.net, rminnich@gmail.com,
        lucho@ionkov.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux_oss@crudebyte.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

That's fair -- and it didn't seem to hurt anything to have DIRSYNC at
the moment, so I can drop this patch if we think its too much noise.
I guess it was more of a reaction the filesystem implicitly setting
mount flags which might override whatever the user intended.  FWIW
SB_SYNCHRONOUS did seem to have an effect on behavior (although I
didn't specifically track down where) -- I noticed this because the
problems Christian found seemed to go away if I mounted the filesystem
with sync (which basically ended up overriding aspects of the cache
configuration I guess).

     -eric

On Sat, Feb 18, 2023 at 3:34 AM <asmadeus@codewreck.org> wrote:
>
> Eric Van Hensbergen wrote on Sat, Feb 18, 2023 at 12:33:16AM +0000:
> > These flags just add unnecessary extra operations.
> > When 9p is run without cache, it inherently implements
> > these options so we don't need them in the superblock
> > (which ends up sending extraneous fsyncs, etc.).  User
> > can still request these options on mount, but we don't
> > need to set them as default.
>
> Hm, I don't see where they'd add any operations -- if you have time
> would you mind pointing me at some?
>
> As far as I can see, it's just about 'sync' or 'dirsync' in /proc/mounts
> and the ST_SYNCHRONOUS statvfs flag; that looks harmless to me and it
> looks more correct to keep to me.
>
> (Sorry, didn't take the time to actually try taking a trace; I've
> checked the flag itself and the IS_SYNC/IS_DIRSYNC -> inode_needs_sync
> wrappers and that only seems used by specific filesystems who'd care
> about users setting the mount options, not the other way aorund.)
>
> --
> Dominique
