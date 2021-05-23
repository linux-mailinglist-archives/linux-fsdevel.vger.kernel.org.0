Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0EB38DD9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 May 2021 00:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhEWWxU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 May 2021 18:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbhEWWxT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 May 2021 18:53:19 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BBEC061574;
        Sun, 23 May 2021 15:51:52 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id 1so19471273qtb.0;
        Sun, 23 May 2021 15:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lzhmHTdCNR5VvClEM+iz/7Eogm7OVbdZpRr+qZMhppo=;
        b=Oj/MaWWY/cgYCwAvZ5EliqEu2GTgveqHVVaaVsBe93hwe3eOAU3khByJtblvwO1Rnu
         BN+62GrdqG41Ab9NldK7sPyKLO3o8pemH+x6f3LfSAAe9q5Vs8SidQ+RoEshyKfeIJFx
         +MwVbJaie2OrAhns/5tHVcsTyyUDCF/aapvRrKE88D4UCJ06roeGF+VSPYk8yqMVJTN/
         NNFMBMuekUzh3lcMfMTbIv4Dzye40A0pzAOxyUCi8sOcL0ewcTakCoTuKXE4U1OoSmYY
         hKyXIjSWwJPJ+paBYQzsAXDP/yv7r8xcXiDNBZi0wpu+ir9E4HnVL1F2zSfZSoNaW0i1
         /Acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lzhmHTdCNR5VvClEM+iz/7Eogm7OVbdZpRr+qZMhppo=;
        b=poZvTFDroc9MslbDsWwBufC50nxAzMxIkPHZwR78EjF+5zHxHqLwqotwwfYVRc3h83
         PxpbteJUzZcNufZJEOTEAx/vXBHxgkGYEBiZSKud9plQrVyfb9uu95EpJXaRpTPLb9FY
         GIrTVMaztbaPIdYVUOMYDDB437s0sbX18WDASQZFufBRjF2hXIZO4gznDbPb//PoICIX
         owguV7XrwwtMjyiFu1kxAvIOVFgtI7aCmJsdU9dwwGRJgZGtBQizOISY41P76Tee4h41
         CmI+EZZ4ZCMSyJ4zHA9BYTjuH7Yct7m8O16VvcWnf7fWR0N2hO8sSFbfyz4hMDxVu64M
         VCmw==
X-Gm-Message-State: AOAM530wYI3sabMvsfxNVd/ptjHf2opsUSIReMUuepOPIgVKWY/CAFz2
        anEADTxE80Xkanq0/dfPE0gPxx9zZTRa
X-Google-Smtp-Source: ABdhPJxv2kVSZxyrvWycz0qyYJVoNfXCEuzJF7N0bld/7vpttbP0tnutxV/x6Yf4x5jMqiO+KRBFmw==
X-Received: by 2002:a05:622a:446:: with SMTP id o6mr24551615qtx.246.1621810311689;
        Sun, 23 May 2021 15:51:51 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id t6sm9962202qkh.117.2021.05.23.15.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 15:51:51 -0700 (PDT)
Date:   Sun, 23 May 2021 18:51:49 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, Kent Overstreet <kmo@daterainc.com>
Subject: Re: [PATCH 1/3] Initial bcachefs support
Message-ID: <YKrchSzj8Zo4CnDs@moria.home.lan>
References: <20210427164419.3729180-1-kent.overstreet@gmail.com>
 <20210427164419.3729180-2-kent.overstreet@gmail.com>
 <YJfzVSGu2BbE4oMY@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJfzVSGu2BbE4oMY@desktop>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 09, 2021 at 10:36:05PM +0800, Eryu Guan wrote:
> On Tue, Apr 27, 2021 at 12:44:17PM -0400, Kent Overstreet wrote:
> > From: Kent Overstreet <kmo@daterainc.com>
> 
> Better to add commit logs at least to give an example about how to setup
> fstests to test bcachefs.
> 
> You could always set MKFS_OPTIONS to "--errors=panic" explicitly when
> needed.

Forgot that was an option - doing that now.
> 
> > +		;;
> >  	*)
> >  		;;
> >  	esac
> > diff --git a/common/dmlogwrites b/common/dmlogwrites
> > index 573f4b8a56..668d49e995 100644
> > --- a/common/dmlogwrites
> > +++ b/common/dmlogwrites
> > @@ -111,6 +111,13 @@ _log_writes_replay_log()
> >  	[ -z "$_blkdev" ] && _fail \
> >  	"block dev must be specified for _log_writes_replay_log"
> >  
> > +	if [ "$FSTYP" = "bcachefs" ]; then
> > +		# bcachefs gets confused if we're replaying the history out of
> > +		# order, and we see writes on the device from a newer point in
> > +		# time than what the superblock points to:
> > +		dd if=/dev/zero of=$SCRATCH_DEV bs=1M oflag=direct >& /dev/null
> 
> I don't know bcachefs internals, I'm not sure I understand this,
> clearing the first 1M of SCRATCH_DEV seems to clear superblock, but I'm
> still not sure why it's needed. Does wipefs work?

It's not just the superblock we need to clear, it's really all metadata - the
journal, and btree nodes are also log structured in bcachefs. So 1M actually
isn't sufficient - the better solution would be to either

 - change the tests to check the markers in the log in the correct order, so
   we never see metadata from a future point in time, also making sure we don't
   do any writes to the filesystem when we're checking the different markers, or
 - just replay to a new dm-thin device

This is basically what I did for generic/482, the 1M zerout is really just a
hack for 455 and 457 and should probably be moved there, unless you've got
another suggestion.

> > diff --git a/common/rc b/common/rc
> > index 2cf550ec68..0e03846aeb 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -334,6 +334,7 @@ _try_scratch_mount()
> >  		return $?
> >  	fi
> >  	_mount -t $FSTYP `_scratch_mount_options $*`
> > +	return
> 
> Seems not necessary.

Not sure how that got in, dropped it.

> > +    bcachefs)
> > +	$MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
> > +	;;
> 
> I think we could just use the default mkfs command below. The only
> difference is dropping the "yes | " part, but that does nothing if mkfs
> doesn't read "yes" or "no" from stdin.

That dates from when my test environment had SIGPIPE set up wrong (systemd!),
it's fixed now so I've dropped these.
> >      *)
> >  	_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_blocksized"
> >  	;;
> > @@ -1179,6 +1197,19 @@ _repair_scratch_fs()
> >  	fi
> >  	return $res
> >          ;;
> > +    bcachefs)
> > +	fsck -t $FSTYP -n $SCRATCH_DEV 2>&1
> 
> _repair_scratch_fs() is supposed to actually fix the errors, does
> "fsck -n" fix errors for bcachefs?

No - but with bcachefs fsck finding errors _always_ indicates a bug, so for the
purposes of these tests I think this is the right thing to do - I don't want the
tests to pass if fsck is finding and fixing errors.

> > diff --git a/tests/generic/042 b/tests/generic/042
> > index 35727bcbc6..42919e2313 100755
> > --- a/tests/generic/042
> > +++ b/tests/generic/042
> > @@ -63,7 +63,8 @@ _crashtest()
> >  
> >  	# We should /never/ see 0xCD in the file, because we wrote that pattern
> >  	# to the filesystem image to expose stale data.
> > -	if hexdump -v -e '/1 "%02X "' $file | grep -q "CD"; then
> > +	# The file is not required to exist since we didn't sync before going down:
> > +	if [[ -f $file ]] && hexdump -v -e '/1 "%02X "' $file | grep -q "CD"; then
> >  		echo "Saw stale data!!!"
> >  		hexdump $file
> >  	fi
> 
> Updates for individual test should be in a separate patch.

Ok, I'll split those out.
