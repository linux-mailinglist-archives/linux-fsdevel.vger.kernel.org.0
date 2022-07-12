Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4E45726ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 22:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbiGLUEM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 16:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbiGLUEB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:04:01 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CF424BC7
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 13:03:59 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id f12so7090007qka.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 13:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kMKOjmUBwk3DBwZ1wD2f24o16PRxuYbW1eYIePsbhDQ=;
        b=uQGQLOsiXfpZ86ny6CuWo3yx26LXTEUepV5jmzcZvl36GEwPxzTi2RzLe1oGZQDjlB
         0f+NMH1L5ZLFMX+lqqiF1RFiICyIYlizzIPGUiFWXlns0eUckwQSkj/7YtubcCC03NIB
         rzUjuPBIq0R6vU98BdSDSW60O/ly9W1DuhjezEkBcj9O4qvddO8g9vrDXk+7hCwej20p
         uGocnGJk+s3DVX+60uLVOwkuhAKIcPi8AHSMz7KBN9nq6sumdwvefS18V1ezbJD/TuuM
         i7TQFXRYISI+K+cl3NL7nNKD7h1lxZ13jy+orCFFMW65c8kRNJyMw+IU06LQKBWATrvs
         58hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kMKOjmUBwk3DBwZ1wD2f24o16PRxuYbW1eYIePsbhDQ=;
        b=BOWCW/uYh0XNmVkHV0jCej/p/aIRt6IdlavB9jciVsKkdMFOfInbrA5uMuoxMQa+Ew
         6acmkiYgFJc/0cYeZ3XOM1z55hadAafCkb7HiD9hwaSINOFnPcvwhklp9qOIhXDrpHBo
         Vu7NHce2D2fhcJmq3SpTsNSht/zivRi1/VqOAExcnkB/EBs5rPxIA4NvdoZjEznz3YtK
         l/4Dg+JRYjvz9FtV5GXO2mJ8nIifC/wx6pKZ0WHl0WcAIy2S9yeFKvOYdWBaj3A0oKL+
         NMYuRIktwabzBoe0mMLV3MxHT7LndTAkQAnb6xCpAffYsfVxQwfdPTCYuWOJvKbBwm++
         co+g==
X-Gm-Message-State: AJIora8DYhKUOLmKSRYMfunEQY3cWYUjMbOUVAnU9HJGQgqzepMKjZto
        6XdO7P8+wexsAG4EF18Uoe14CA==
X-Google-Smtp-Source: AGRyM1tIYCEUQctCZmssJsI+cL7Kc7QBMgFp82gyvnI3n6+1CyNTLQF820YsTYkp+a5q7Jpfj6ZIPw==
X-Received: by 2002:a05:620a:1d0d:b0:6b5:774e:9a27 with SMTP id dl13-20020a05620a1d0d00b006b5774e9a27mr11253608qkb.280.1657656238937;
        Tue, 12 Jul 2022 13:03:58 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c73-20020ae9ed4c000000b006a37c908d33sm9583235qkg.28.2022.07.12.13.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 13:03:58 -0700 (PDT)
Date:   Tue, 12 Jul 2022 16:03:56 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     ansgar.loesser@kom.tu-darmstadt.de,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?iso-8859-1?Q?Bj=F6rn?= Scheuermann 
        <scheuermann@kom.tu-darmstadt.de>
Subject: Re: Information Leak: FIDEDUPERANGE ioctl allows reading writeonly
 files
Message-ID: <Ys3TrAf95FpRgr+P@localhost.localdomain>
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
 <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
 <CAEzrpqdweuZ2ufMKDJwSzP5W021F7mgS+7toSo6VDgvDzd0ZqA@mail.gmail.com>
 <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 12, 2022 at 12:07:46PM -0700, Linus Torvalds wrote:
> On Tue, Jul 12, 2022 at 12:02 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > > Any permission checks done at IO time are basically always buggy:
> > > things may have changed since the 'open()', and those changes
> > > explicitly should *not* matter for the IO. That's really fundamentally
> > > how UNIX file permissions work.
> >
> > I don't think we should go this far, after all the normal
> > write()/read() syscalls do the permission checking each time as well,
> 
> No, they really don't.
> 
> The permission check is ONLY DONE AT OPEN TIME.
> 
> Really. Go look.
>

I did, I just misread what rw_verify_area was doing, it's just doing the
security check, not a full POSIX permissions check, my mistake.

> Anything else is a bug. If you open a file, and then change the
> permissions of the file (or the ownership, or whatever) afterwards,
> the open file descriptor is still supposed to be readable or writable.
> 
> Doing IO time permission checks is not only wrong, it's ACTIVELY
> BUGGY, and is a fairly common source of security problems (ie passing
> a file descriptor off to a suid binary, and then using the suid
> permissions to make changes that the original opener didn't have the
> rights to do).
> 
> So if you do permission checks at read/write time, you are a buggy
> mess.  It really is that simple.
> 
> This is why read and write check FMODE_READ and FMODE_WRITE. That's
> the *open* time check.
> 
> The fact that dedupe does that inode_permission() check at IO time
> really looks completely bogus and buggy.
> 

Yeah I'm fine with removing the inode_permission(), I just want to make sure
we're consistent across all of our IO related operations.  It looks like at the
very least we're getting security_*_permission on things like
read/write/fallocate, so perhaps switch to that here and call it good enough?
Thanks,

Josef
