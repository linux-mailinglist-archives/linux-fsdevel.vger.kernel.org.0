Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BE640CCA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 20:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhIOShy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 14:37:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231358AbhIOShp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:37:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B11660F92;
        Wed, 15 Sep 2021 18:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631730985;
        bh=LIRkG7b1PBZBUUKadHBEneTsBXwFII2aWFaHfPJGcd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hdg6Iw8ZlACzeoWDxdtJ8oOVOXyNgemaIoY/UGc+iz8mO0yZmTUqu1qN7JAxcvmNU
         OGMdqIAvfKMXXWGCx3IrpJsEEZ1ItUoFDm8C5rNcJNBvaS3yPP5Ycd26YZmB2WDDjX
         rTRxS+2C07j9uXQZx7nPQ96vN0t85QeJ0hrfTW8QgrvqC4VBuRzX7LehzmCkEVA1iV
         hAc32kWTLmxX0AEfQlQe+jQBJFRmENc4hryFbp1NjGy5kXY0Uh5kgEUH5ky9I9IDF5
         Xjbnff1gsDoWLsVWrg+DN2d92vQbNQnzA4nC8u/xIBHIXbufph/W2NNxoNtPSt8UyD
         X139DY47pS9Kg==
Received: by pali.im (Postfix)
        id 30B725E1; Wed, 15 Sep 2021 20:36:23 +0200 (CEST)
Date:   Wed, 15 Sep 2021 20:36:23 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        Marcos Mello <marcosfrm@gmail.com>, ntfs3@lists.linux.dev,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ntfs3 mount options
Message-ID: <20210915183623.vzxwetrodw5tn3z3@pali>
References: <CAJZVDJAJa+j=hx2JswdvS35t9VU6TYF3uDZnzZ5hhtSzo9E-LA@mail.gmail.com>
 <CAC=eVgQKOdNbyDf2Qf=O9SnG=6nAGZ-nyuwOosf7YW5R3xbVLw@mail.gmail.com>
 <20210912184347.zrb44vpc3lfyy3px@pali>
 <20210912194859.saoxuy3bbi2mmj5x@kari-VirtualBox>
 <367b6153-c044-da71-39ed-132c0b79690f@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <367b6153-c044-da71-39ed-132c0b79690f@paragon-software.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tuesday 14 September 2021 19:33:32 Konstantin Komarov wrote:
> On 12.09.2021 22:48, Kari Argillander wrote:
> > On Sun, Sep 12, 2021 at 08:43:47PM +0200, Pali Rohár wrote:
> >> Hello!
> >>
> >> On Friday 10 September 2021 15:19:16 Kari Argillander wrote:
> >>> 10.09.2021 14.23 Marcos Mello (marcosfrm@gmail.com) wrote:
> >>>> Hi, sorry email you directly, but this mailing list thing is cryptic
> >>>> to me.
> >>>
> >>> I CC also lists to this so now everyone knows. Also CC couple
> >>> others who might be interested to talk about this.
> >>>
> >>>> I was reading your patches cleaning up ntfs3 documentation and
> >>>> realized some mount options diverge from NTFS-3G. This will make
> >>>> udisks people unhappy.
> >>
> >> If you still have to specify which fs driver want to use (ntfs, ntfs-3g,
> >> ntfs3). So each software needs to be adjusted if want to start using
> >> different fs driver even when mount options are same. So I think there
> >> are no big issues that different fs driver are using different mount
> >> options.
> >>
> >>> This is true. They also diverge from the current NTFS driver. We have
> >>> talk about it a little bit and before ntfs driver can go out from kernel we
> >>> need to support those flags or at least some. udisk currently does only
> >>> support NTFS-3G and it does not support kernel ntfs driver. So nothing
> >>> will change.
> >>>
> >>> I also agree that we should check mount options from ntfs-3g and maybe
> >>> implement them in. Maybe we can just take some mount options with
> >>> deprecated and print that this option is meant to use with ntfs-3g please
> >>> note that this is kernel ntfs3 driver or something. It would still work for
> >>> users. Ntfs-3g contains imo lot of unnecessary flags. Kernel community
> >>> would probably not want to maintain so large list of different options.
> >>
> >> Mount options which makes sense could be implemented. Just somebody
> >> needs to do it.
> >>
> >>> Ntfs-3g group also has acounted problems because they say that you
> >>> should example use "big_writes", but not everyone does and that drops
> >>> performance. Driver should work good way by default.
> >>
> >> I agree. Mount option which is just a hack because of some poor
> >> implementation should not be introduced. Instead bugs should be fixed.
> >> Also it applies for "performance issues" which do not change behavior of
> >> fs operations (i.e. read() / write() operations do same thing on raw
> >> disk).
> >>
> >>> And only if there
> >>> is really demand there should be real mount option. But like I said, maybe
> >>> we should add "fake" ntfs-3g options so if some user change to use ntfs3
> >>> it will be pretty painless.
> >>
> >> This really should not be in kernel. You can implement userspace mount
> >> helper which translates "legacy" ntfs-3g options into "correct" kernel
> >> options. /bin/mount already supports these helpers / wrappers... Just
> >> people do not know much about them.
> > 
> > Good to know. Thanks for this info.
> > 
> >>
> >>>> NTFS-3G options:
> >>>> https://github.com/tuxera/ntfs-3g/blob/edge/src/ntfs-3g.8.in
> >>>>
> >>>> UDISKS default and allowed options:
> >>>> https://github.com/storaged-project/udisks/blob/master/data/builtin_mount_options.conf
> >>>>
> >>>> For example, windows_names is not supported in ntfs3 and
> >>>> show_sys_files should probably be an alias to showmeta.
> >>>
> >>> Imo windows_names is good option. There is so many users who just
> >>> want to use this with dual boot. That is why I think best option would
> >>> be windows_compatible or something. Then we do everything to user
> >>> not screw up things with disk and that when he checks disk with windows
> >>> everything will be ok. This option has to also select ignore_case.
> >>>
> >>> But right now we are horry to take every mount option away what we won't
> >>> need. We can add options later. And this is so early that we really cannot
> >>> think so much how UDSIKS threats ntfs-3g. It should imo not be problem
> >>> for them to also support for ntfs3 with different options.
> >>
> >> This is something which needs to be handled and fixed systematically. We
> >> have at least 5 filesystems in kernel (bonus question, try to guess
> >> them :D) which support some kind/parts of "windows nt" functionality.
> >> And it is pain if every one fs would use different option for
> >> similar/same functionality.
> > 
> > Hopefully we can tackle this issue someday. But we will have lot of
> > deprecated options if we tackle this, but it is good thing and should
> > done in some point. I will answer your bonus question when we can throw
> > away one of those drivers.
> > 
> >>>> Also, is NTFS-3G locale= equivalent to ntfs3 nls=?
> >>>
> >>> Pretty much. It is now called iocharset and nls will be deprecated.
> >>> This is work towards that every Linux kernel filesystem driver which
> >>> depends on this option will be same name. Ntfs-3g should also use
> >>> it.
> >>
> >> iocharset= is what most fs supports. Just few name this option as nls=
> >> and for consistency I preparing patches which adds iocharset= alias for
> >> all kernel filesystems. nls= (for those few fs) stay supported as legacy
> >> alias for iocharset=.
> >>
> >> Kari, now I'm thinking about nls= in new ntfs3 kernel driver. It is
> >> currently being marked as deprecated. Does it really make sense to
> >> introduce in new fs already deprecated option? Now when final linux
> >> version which introduce this driver was not released yet, we can simply
> >> drop (= do not introduce this option). 
> > 
> > We have discuss this earlier [1]. I think Konstantin can really decide
> > this one. I think it is he "rights" like was kinda chosen that ntfs64
> > can live in kernel because Paragon say some of they customers need it. I
> > have after that include big warning about using it. Because thing is
> > that if Paragon will not support it nobady will and someone will just
> > drop support for it.
> > 
> > Marking some option to deprecated is just 4 trivial line of code. I also
> > did not even bother to documented it. I can live with that if we won't
> > have this option but it can be little easier to some if we have that.
> > And I really do not mind if 4 extra line code inside structs. So my vote
> > is for deprecated.
> > 
> > Konstantion: Can you give us your opionion on this one?
> 
> Before answering I want to know: is it easy to remove deprecated option
> from code? I read different opinions in this thread.

Removal is a problem in general as kernel should provide backward
compatibility with features and APIs which were already released.

> If removal will be easy, then I vote for deprecated option.
> Supporting familiar mount options will help in transition.
> After some time (one or two kernel releases?) this support can be dropped.
> 
> If removal will be hard, then better to remove now.
> It will make things a bit harder for user, but it's better, than
> having a list of deprecated options, that do nothing and will be there forever.
> 
> > 
> > [1]: https://lore.kernel.org/ntfs3/20210819095527.w4uv6gzuyaotxjpe@pali/
> > 
> >> But after release, there would be no easy way to remove it. Adding a
> >> new option can be done at any time later easily...
> > 
> > I think if something is has been deprecated from the start we can just
> > drop it when ever we want, but maybe we should add comment there and
> > just choose that first release in 2027 will not anymore have this
> > option. I recommend that you made this kind of thing in your patch
> > series too. XFS has commented nicely that we really drop this in x date.
> > This way decision is made before and then even janitor can come and
> > clean it when that time comes.
> > 
> >   Argillander
> > 
> >>>> Thank you a lot for all the work put into ntfs3!
> >>>>
> >>>> Marcos
> >>
