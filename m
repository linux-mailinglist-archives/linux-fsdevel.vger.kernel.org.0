Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BD5407FCA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Sep 2021 21:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236080AbhILTuT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Sep 2021 15:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbhILTuT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Sep 2021 15:50:19 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC78FC061574;
        Sun, 12 Sep 2021 12:49:03 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id h16so16367101lfk.10;
        Sun, 12 Sep 2021 12:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LT3KEQ/s5RUYlZwGt09hqt0imjDHSs2K6UhNMnlfoqg=;
        b=ckYaiituYNi8w5HBu+6Jf5AapiUF5XEemTh1FEDwW1IJEPkfOkzyimHZzytB+eTXqf
         rjnACs2qME0HcMYcl5b6d18qc0D3me8AinSk6t0FCUgXF/0/vzq331lw7uTgMP5OXElp
         KnExheeo55U/hDKZblLR9v96pTvGGCUZ3BCYKDUpwI88nEZPdZMHCNLMiJZnSD52JyCU
         k5GRPOU9wDUYOuBiJyFud1+gYzzTWzJVaa6UqtcGR7KcMUqsyRsOY5fviP8Sv17bCj89
         LTH7r8nFqU+yROJNcSmgcIcPIxupvsFgbchwUasyfCuqDKzm+0gbr850c9ISP3S+Ty+p
         cqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LT3KEQ/s5RUYlZwGt09hqt0imjDHSs2K6UhNMnlfoqg=;
        b=hvSLcncTp+3sCuzUumj/22erKaddvzZYTIWDkxEtFpmJTTxZwA1o9ArIppCUYtrGFh
         rG3PkwRBkDgm7IP68aM21wmiywmrQFPGvas+J3bkuPznO/jAWW/5pSGWeinoJvTd8AYQ
         +Seg4LKUiOW+NL63nrEo5SBYkzjY8hwB0UdUw9ASqPclOjV+/5Rs1ZaTMTDRsFUqN2f2
         DT3Pl2X5Kkc+90tO+1W/h6STNwkFU4vVcip1GJffQg5JQ9dOuzRc+Exr3ICr1n1mvs+N
         bdGBBttfiJmjAmgtzXKa6ouDYnc5pfdFku7XLDj9ov8IS0SK/1ysrhNVT+USV33CYle0
         HI1w==
X-Gm-Message-State: AOAM531oQZ/nDjv+OribQHG2Ma8R3pCWEvhJTJwiKLTtMgPhc9rnEQnI
        x4m3E8FM0JKTA4TURAldkRI=
X-Google-Smtp-Source: ABdhPJxCQwnTIu2979T5IKnfgf8ONMQnBZiri4bLOBhO2W873JaP6FwuyX3wrrbnW8EmAe2gYdutNw==
X-Received: by 2002:a05:6512:234e:: with SMTP id p14mr6257732lfu.324.1631476142107;
        Sun, 12 Sep 2021 12:49:02 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id y1sm598502lfb.297.2021.09.12.12.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 12:49:01 -0700 (PDT)
Date:   Sun, 12 Sep 2021 22:48:59 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Marcos Mello <marcosfrm@gmail.com>, ntfs3@lists.linux.dev,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ntfs3 mount options
Message-ID: <20210912194859.saoxuy3bbi2mmj5x@kari-VirtualBox>
References: <CAJZVDJAJa+j=hx2JswdvS35t9VU6TYF3uDZnzZ5hhtSzo9E-LA@mail.gmail.com>
 <CAC=eVgQKOdNbyDf2Qf=O9SnG=6nAGZ-nyuwOosf7YW5R3xbVLw@mail.gmail.com>
 <20210912184347.zrb44vpc3lfyy3px@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210912184347.zrb44vpc3lfyy3px@pali>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 12, 2021 at 08:43:47PM +0200, Pali Rohár wrote:
> Hello!
> 
> On Friday 10 September 2021 15:19:16 Kari Argillander wrote:
> > 10.09.2021 14.23 Marcos Mello (marcosfrm@gmail.com) wrote:
> > > Hi, sorry email you directly, but this mailing list thing is cryptic
> > > to me.
> > 
> > I CC also lists to this so now everyone knows. Also CC couple
> > others who might be interested to talk about this.
> > 
> > > I was reading your patches cleaning up ntfs3 documentation and
> > > realized some mount options diverge from NTFS-3G. This will make
> > > udisks people unhappy.
> 
> If you still have to specify which fs driver want to use (ntfs, ntfs-3g,
> ntfs3). So each software needs to be adjusted if want to start using
> different fs driver even when mount options are same. So I think there
> are no big issues that different fs driver are using different mount
> options.
> 
> > This is true. They also diverge from the current NTFS driver. We have
> > talk about it a little bit and before ntfs driver can go out from kernel we
> > need to support those flags or at least some. udisk currently does only
> > support NTFS-3G and it does not support kernel ntfs driver. So nothing
> > will change.
> > 
> > I also agree that we should check mount options from ntfs-3g and maybe
> > implement them in. Maybe we can just take some mount options with
> > deprecated and print that this option is meant to use with ntfs-3g please
> > note that this is kernel ntfs3 driver or something. It would still work for
> > users. Ntfs-3g contains imo lot of unnecessary flags. Kernel community
> > would probably not want to maintain so large list of different options.
> 
> Mount options which makes sense could be implemented. Just somebody
> needs to do it.
> 
> > Ntfs-3g group also has acounted problems because they say that you
> > should example use "big_writes", but not everyone does and that drops
> > performance. Driver should work good way by default.
> 
> I agree. Mount option which is just a hack because of some poor
> implementation should not be introduced. Instead bugs should be fixed.
> Also it applies for "performance issues" which do not change behavior of
> fs operations (i.e. read() / write() operations do same thing on raw
> disk).
> 
> > And only if there
> > is really demand there should be real mount option. But like I said, maybe
> > we should add "fake" ntfs-3g options so if some user change to use ntfs3
> > it will be pretty painless.
> 
> This really should not be in kernel. You can implement userspace mount
> helper which translates "legacy" ntfs-3g options into "correct" kernel
> options. /bin/mount already supports these helpers / wrappers... Just
> people do not know much about them.

Good to know. Thanks for this info.

> 
> > > NTFS-3G options:
> > > https://github.com/tuxera/ntfs-3g/blob/edge/src/ntfs-3g.8.in
> > >
> > > UDISKS default and allowed options:
> > > https://github.com/storaged-project/udisks/blob/master/data/builtin_mount_options.conf
> > >
> > > For example, windows_names is not supported in ntfs3 and
> > > show_sys_files should probably be an alias to showmeta.
> > 
> > Imo windows_names is good option. There is so many users who just
> > want to use this with dual boot. That is why I think best option would
> > be windows_compatible or something. Then we do everything to user
> > not screw up things with disk and that when he checks disk with windows
> > everything will be ok. This option has to also select ignore_case.
> > 
> > But right now we are horry to take every mount option away what we won't
> > need. We can add options later. And this is so early that we really cannot
> > think so much how UDSIKS threats ntfs-3g. It should imo not be problem
> > for them to also support for ntfs3 with different options.
> 
> This is something which needs to be handled and fixed systematically. We
> have at least 5 filesystems in kernel (bonus question, try to guess
> them :D) which support some kind/parts of "windows nt" functionality.
> And it is pain if every one fs would use different option for
> similar/same functionality.

Hopefully we can tackle this issue someday. But we will have lot of
deprecated options if we tackle this, but it is good thing and should
done in some point. I will answer your bonus question when we can throw
away one of those drivers.

> > > Also, is NTFS-3G locale= equivalent to ntfs3 nls=?
> > 
> > Pretty much. It is now called iocharset and nls will be deprecated.
> > This is work towards that every Linux kernel filesystem driver which
> > depends on this option will be same name. Ntfs-3g should also use
> > it.
> 
> iocharset= is what most fs supports. Just few name this option as nls=
> and for consistency I preparing patches which adds iocharset= alias for
> all kernel filesystems. nls= (for those few fs) stay supported as legacy
> alias for iocharset=.
> 
> Kari, now I'm thinking about nls= in new ntfs3 kernel driver. It is
> currently being marked as deprecated. Does it really make sense to
> introduce in new fs already deprecated option? Now when final linux
> version which introduce this driver was not released yet, we can simply
> drop (= do not introduce this option). 

We have discuss this earlier [1]. I think Konstantin can really decide
this one. I think it is he "rights" like was kinda chosen that ntfs64
can live in kernel because Paragon say some of they customers need it. I
have after that include big warning about using it. Because thing is
that if Paragon will not support it nobady will and someone will just
drop support for it.

Marking some option to deprecated is just 4 trivial line of code. I also
did not even bother to documented it. I can live with that if we won't
have this option but it can be little easier to some if we have that.
And I really do not mind if 4 extra line code inside structs. So my vote
is for deprecated.

Konstantion: Can you give us your opionion on this one?

[1]: https://lore.kernel.org/ntfs3/20210819095527.w4uv6gzuyaotxjpe@pali/

> But after release, there would be no easy way to remove it. Adding a
> new option can be done at any time later easily...

I think if something is has been deprecated from the start we can just
drop it when ever we want, but maybe we should add comment there and
just choose that first release in 2027 will not anymore have this
option. I recommend that you made this kind of thing in your patch
series too. XFS has commented nicely that we really drop this in x date.
This way decision is made before and then even janitor can come and
clean it when that time comes.

  Argillander

> > > Thank you a lot for all the work put into ntfs3!
> > >
> > > Marcos
> 
