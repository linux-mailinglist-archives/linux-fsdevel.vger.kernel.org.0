Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92B77169840
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 16:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgBWPHi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 10:07:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36071 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgBWPHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 10:07:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id 185so3946742pfv.3;
        Sun, 23 Feb 2020 07:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bdqu5abNrvJYTPmzTrUajT1OezURW2GaP1fXp+ZPktc=;
        b=HRHTLCyJCLudZAbV0d8WuLq0BO/knVg1KSZuwYen344WkVUjkt5jKejmpobJBCTHw6
         QIrmUakh0oGR5WMZgHLur1SFuLOJ5EIA3GJQLaywtgYUioZ2rNKEeGZkj+SS4LP/Y/oF
         0KavWaL5JnIkV5RAxki5nZPg15K3IroBoZEdq5k3wK4n182vgn2fSm3lcQgUT8NDuVf+
         fTIofmdUYUoMDyXBnThcaP/w0Q5bv1s5AIIEjKqQeJY2ohPM2npDpUs7cGU77lmVIHT4
         qJfskPaniPlcrP2sZ9jdTURtmZyRsNrpCv2xzNI4TzwVAYVlgqrxq+679bKvNdjo7hrr
         evgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bdqu5abNrvJYTPmzTrUajT1OezURW2GaP1fXp+ZPktc=;
        b=T+3xE+l9Yng1JeuTZKPEUYTAvkOBWo8gx/QGAnDUoEvMVVgiLAP2bV7ViXKnLEaA5X
         aVvQkPdRnHFI/BUXfqClHqHXD6gzY6E03l1imW9GA/MYW3dQZxlBPM4Pcter9NJR24nk
         a7G1er0yjVgEXIrdoWL7u6+qBue3lu5W84rb4TM2dWu8u2NdZv213Mgab6g10wYBxESS
         vMw/ZkoTGu8ndNKRBAf0MQN2jgEX3W8V2Ifb6n09UmvRUUljPzOvrgFCzwDM5M3r6uR4
         Dr+lZOAE4cX3BmktLLqP400YPNyfTei+jeRYQZ+neQ3UibgWdufYAZgAvNo+1PhTEQcW
         mAlg==
X-Gm-Message-State: APjAAAWVT5KqoGbVinNZvp7jYA9xg/xuhuLz287CeO9gD3lK9EbHmuZW
        Dze/vfYRClqDA1LJP+ZKfqY=
X-Google-Smtp-Source: APXvYqzPgADI5Q6uCzHpANBpjUoBgYZLiOg04p47TLmpV5sXJHYv9bmQ0lNWMQnL4hA0ub1tNodgfA==
X-Received: by 2002:a62:820e:: with SMTP id w14mr8421280pfd.59.1582470456932;
        Sun, 23 Feb 2020 07:07:36 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id o14sm9067252pgm.67.2020.02.23.07.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 07:07:36 -0800 (PST)
Date:   Sun, 23 Feb 2020 23:07:15 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     zlang@redhat.com
Cc:     Jeff Moyer <jmoyer@redhat.com>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH V2 1/3] dax/dm: disable testing on devices that don't
 support dax
Message-ID: <20200223150056.GG3840@desktop>
References: <20200220200632.14075-1-jmoyer@redhat.com>
 <20200220200632.14075-2-jmoyer@redhat.com>
 <20200221094801.GJ14282@dhcp-12-102.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221094801.GJ14282@dhcp-12-102.nay.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 05:48:01PM +0800, Zorro Lang wrote:
> On Thu, Feb 20, 2020 at 03:06:30PM -0500, Jeff Moyer wrote:
> > Move the check for dax from the individual target scripts into
> > _require_dm_target.  This fixes up a couple of missed tests that are
> > failing due to the lack of dax support (such as tests requiring
> > dm-snapshot).
> > 
> > Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> > ---
> >  common/dmdelay  |  5 -----
> >  common/dmerror  |  5 -----
> >  common/dmflakey |  5 -----
> >  common/dmthin   |  5 -----
> >  common/rc       | 11 +++++++++++
> >  5 files changed, 11 insertions(+), 20 deletions(-)
> > 
> > diff --git a/common/dmdelay b/common/dmdelay
> > index f1e725b9..66cac1a7 100644
> > --- a/common/dmdelay
> > +++ b/common/dmdelay
> > @@ -7,11 +7,6 @@
> >  DELAY_NONE=0
> >  DELAY_READ=1
> >  
> > -echo $MOUNT_OPTIONS | grep -q dax
> > -if [ $? -eq 0 ]; then
> > -	_notrun "Cannot run tests with DAX on dmdelay devices"
> > -fi
> > -
> >  _init_delay()
> >  {
> >  	local BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
> > diff --git a/common/dmerror b/common/dmerror
> > index 426f1e96..7d12e0a1 100644
> > --- a/common/dmerror
> > +++ b/common/dmerror
> > @@ -4,11 +4,6 @@
> >  #
> >  # common functions for setting up and tearing down a dmerror device
> >  
> > -echo $MOUNT_OPTIONS | grep -q dax
> > -if [ $? -eq 0 ]; then
> > -	_notrun "Cannot run tests with DAX on dmerror devices"
> > -fi
> > -
> >  _dmerror_setup()
> >  {
> >  	local dm_backing_dev=$SCRATCH_DEV
> > diff --git a/common/dmflakey b/common/dmflakey
> > index 2af3924d..b4e11ae9 100644
> > --- a/common/dmflakey
> > +++ b/common/dmflakey
> > @@ -8,11 +8,6 @@ FLAKEY_ALLOW_WRITES=0
> >  FLAKEY_DROP_WRITES=1
> >  FLAKEY_ERROR_WRITES=2
> >  
> > -echo $MOUNT_OPTIONS | grep -q dax
> > -if [ $? -eq 0 ]; then
> > -	_notrun "Cannot run tests with DAX on dmflakey devices"
> > -fi
> > -
> >  _init_flakey()
> >  {
> >  	local BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
> > diff --git a/common/dmthin b/common/dmthin
> > index 7946e9a7..61dd6f89 100644
> > --- a/common/dmthin
> > +++ b/common/dmthin
> > @@ -21,11 +21,6 @@ DMTHIN_POOL_DEV="/dev/mapper/$DMTHIN_POOL_NAME"
> >  DMTHIN_VOL_NAME="thin-vol"
> >  DMTHIN_VOL_DEV="/dev/mapper/$DMTHIN_VOL_NAME"
> >  
> > -echo $MOUNT_OPTIONS | grep -q dax
> > -if [ $? -eq 0 ]; then
> > -	_notrun "Cannot run tests with DAX on dmthin devices"
> > -fi
> > -
> >  _dmthin_cleanup()
> >  {
> >  	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
> > diff --git a/common/rc b/common/rc
> > index eeac1355..65cde32b 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -1874,6 +1874,17 @@ _require_dm_target()
> >  	_require_sane_bdev_flush $SCRATCH_DEV
> >  	_require_command "$DMSETUP_PROG" dmsetup
> >  
> > +	echo $MOUNT_OPTIONS | grep -q dax
> > +	if [ $? -eq 0 ]; then
> > +		case $target in
> > +		stripe|linear|log-writes)
> 
> I've checked all cases which import ./common/dm.* (without dmapi), they all
> has _require_dm_target. So this patch is good to me.

So can I add "Reviewed-by: Zorro Lang <zlang@redhat.com>" to all these
three patches? :)

Thanks for the review!

Eryu
> 
> And by checking current linux source code:
> 
>   0 dm-linear.c      226 .direct_access = linear_dax_direct_access,
>   1 dm-log-writes.c 1016 .direct_access = log_writes_dax_direct_access,
>   2 dm-stripe.c      486 .direct_access = stripe_dax_direct_access,
>   3 dm-target.c      159 .direct_access = io_err_dax_direct_access,
> 
> Only linear, stripe and log-writes support direct_access.
> 
> Thanks,
> Zorro
> 
> > +			;;
> > +		*)
> > +			_notrun "Cannot run tests with DAX on $target devices."
> > +			;;
> > +		esac
> > +	fi
> > +
> >  	modprobe dm-$target >/dev/null 2>&1
> >  
> >  	$DMSETUP_PROG targets 2>&1 | grep -q ^$target
> > -- 
> > 2.19.1
> > 
> 
