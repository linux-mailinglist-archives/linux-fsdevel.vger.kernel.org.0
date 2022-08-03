Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515D55886D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 07:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbiHCFjA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 01:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiHCFi7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 01:38:59 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0933D58D;
        Tue,  2 Aug 2022 22:38:58 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id y22so6392683uay.1;
        Tue, 02 Aug 2022 22:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ur8yS6+TWe0TMV+PuQGqJWqnthLGUnwvuGH8KpEmvRY=;
        b=mmaOzmEDUGrAZQP1Kfn7C7n23dzrEjrSEKquFIcsu5wu2J4a1SNAhPJ2noQAQC+qAn
         tXmnldA38IfXGJvOLrczIEgtRMutaWdRdM/Q3kmnoOE4Vp0qRG9kEefSCY6ttkZDa/ze
         /ZCKOc5rlexsQo371y6WnMHPprUnx7t4+tfjNiTzJe+f1zi4Bizew50kdeY2gf9PQBoh
         s7ckiFjJ26DIibH5x7xi/ElX11SnMt+1zdhT1F4G58Kh7P5nF2gzOttm/7QYTVCNOusb
         BC9O2RzDlNxyFOhkteMhZn2ntI3xZBLMfk+Ld9b564dPvnlNal4Hkkl4h2Jpjv8SPecw
         jHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ur8yS6+TWe0TMV+PuQGqJWqnthLGUnwvuGH8KpEmvRY=;
        b=G3rKazBJT/IncgEEdMmQpCgbSGYr2X6PYlHF1FeKg/n8uvPMmc+YTPp0tk7OZZ0fke
         AfLUPP6uRvRsBUYgwhjgDQJAY+IivzPr84Gxr6yPbXaOUz0BNhW3jxPTcgdCcP6hW4Co
         cS0sPv2vnJY/YKb1sa+j4DD9lwSHJSB/tuRCjLJ3eAvYeSR3dATezJu8MHWVIeMzynTT
         wrgVys377IcTM49WL4FB4YiR8fh2d657UK8UKhx7xSd9VwKXVtLG22CNJ5kljSIyEDS7
         SD53YW1uiPZBOqOcELgRwDvce84n2Y7EKMtCrK81KPQ4d6ZuzIH8zrtnI9pUbVjfZLae
         2ybQ==
X-Gm-Message-State: ACgBeo268O87VmfbdquiEF6TOy/vGueatNrD2zu0/as9PUYjg19nR+DA
        0cBjlD2NWPh/3CKlB9bpRgwtCix7jsC5gTrf43A=
X-Google-Smtp-Source: AA6agR73lM3/EP3ZZOPX6NAMi/klqc8sqT34+G4YQjOuC8AkLlB2p1gslc5VEujlyIkK+As5QqA+qEivW724gb063Wg=
X-Received: by 2002:a05:6130:10b:b0:37f:a52:99fd with SMTP id
 h11-20020a056130010b00b0037f0a5299fdmr9111079uag.96.1659505137662; Tue, 02
 Aug 2022 22:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220801190933.27197-1-ematsumiya@suse.de> <c05f4fc668fa97e737758ab03030d7170c0edbd9.camel@kernel.org>
 <20220802193620.dyvt5qiszm2pobsr@cyberdelia> <6f3479265b446d180d71832fd0c12650b908ebe2.camel@kernel.org>
 <1c2e8880-3efe-b55d-ee50-87d57efc3130@talpey.com>
In-Reply-To: <1c2e8880-3efe-b55d-ee50-87d57efc3130@talpey.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 3 Aug 2022 00:38:46 -0500
Message-ID: <CAH2r5mtWn85=RknxfE2p=Zo24H2ynin2ReLV1jijSG-yLN9J4w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Rename "cifs" module to "smbfs"
To:     Tom Talpey <tom@talpey.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        CIFS <linux-cifs@vger.kernel.org>, Paulo Alcantara <pc@cjr.nz>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        Pavel Shilovsky <pshilovsky@samba.org>
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

On Tue, Aug 2, 2022 at 8:32 PM Tom Talpey <tom@talpey.com> wrote:
>
> On 8/2/2022 4:07 PM, Jeff Layton wrote:
> > On Tue, 2022-08-02 at 16:36 -0300, Enzo Matsumiya wrote:
> >> On 08/02, Jeff Layton wrote:
> >>> On Mon, 2022-08-01 at 16:09 -0300, Enzo Matsumiya wrote:
> >>>> Hi,
> >>>>
> >>>> As part of the ongoing effort to remove the "cifs" nomenclature from the
> >>>> Linux SMB client, I'm proposing the rename of the module to "smbfs".
> >>>>
> >>>> As it's widely known, CIFS is associated to SMB1.0, which, in turn, is
> >>>> associated with the security issues it presented in the past. Using
> >>>> "SMBFS" makes clear what's the protocol in use for outsiders, but also
> >>>> unties it from any particular protocol version. It also fits in the
> >>>> already existing "fs/smbfs_common" and "fs/ksmbd" naming scheme.
> >>>>
> >>>> This short patch series only changes directory names and includes/ifdefs in
> >>>> headers and source code, and updates docs to reflect the rename. Other
> >>>> than that, no source code/functionality is modified (WIP though).
> >>>>
> >>>> Patch 1/3: effectively changes the module name to "smbfs" and create a
> >>>>       "cifs" module alias to maintain compatibility (a warning
> >>>>       should be added to indicate the complete removal/isolation of
> >>>>       CIFS/SMB1.0 code).
> >>>> Patch 2/3: rename the source-code directory to align with the new module
> >>>>       name
> >>>> Patch 3/3: update documentation references to "fs/cifs" or "cifs.ko" or
> >>>>       "cifs module" to use the new name
> >>>>
> >>>> Enzo Matsumiya (3):
> >>>>    cifs: change module name to "smbfs.ko"
> >>>>    smbfs: rename directory "fs/cifs" -> "fs/smbfs"
> >>>>    smbfs: update doc references
> >>>> ...
> >>>
> >>> Why do this? My inclination is to say NAK here.
> >>>
> >>> This seems like a lot of change for not a lot of benefit. Renaming the
> >>> directory like this pretty much guarantees that backporting patches
> >>> after this change to kernels that existed before it will be very
> >>> difficult.
> >>
> >> Hi Jeff, yes that's a big concern that I've discussed internally with my
> >> team as well, since we'll also suffer from those future backports.
> >>
> >> But, as stated in the commit message, and from what I gathered from
> >> Steve, it has been an ongoing wish to have the "cifs" name no longer
> >> associated with a module handling SMB2.0 and SMB3.0, as the name brings
> >> back old bad memories for several users.
> >>
> >> There really is no functional benefit for this change, and I have no
> >> argument against that.
> >>
> >
> > If the concern is "branding" then I don't see how this really helps.
> > Very few users interact with the kernel modules directly.
> >
> > FWIW, I just called "modprobe smb3" on my workstation and got this:
> >
> > [ 1223.581583] Key type cifs.spnego registered
> > [ 1223.582523] Key type cifs.idmap registered
> > [ 1230.411422] Key type cifs.idmap unregistered
> > [ 1230.412542] Key type cifs.spnego unregistered
> >
> > Are you going to rename the keyrings too? That will have implications
> > for userland helper programs like cifs.upcall. There's also
> > /proc/fs/cifs/*.
> >
> > These are a "stable interfaces" that you can't just rename at will. If
> > you want to change these interfaces then you need to do a formal
> > deprecation announcement, and probably a period with /proc/fs/smbfs and
> > /proc/fs/cifs coexisting.
> >
> > There are also a ton of printk's and such that have "CIFS" in them that
> > will need to be changed.
> >
> > These costs do not seem worth the perceived benefit to me. You could
> > probably hide a lot of what users see by just renaming (or symlinking)
> > mount.cifs to mount.smb3.
> >
> > I think if you guys are serious about this, you should probably start
> > somewhere else besides renaming the directory and module. This is going
> > to impact developers (and people who make their living doing backports)
> > far more than it will users.
>
> The initial goal is to modularize the SMB1 code, so it can be completely
> removed from a running system. The extensive refactoring logically leads
> to this directory renaming, but renaming is basically a side effect.
>
> Stamping out the four-letter word C-I-F-S is a secondary goal. At this
> point, the industry has stopped using it. You make a good point that
> it's still visible outside the kernel source though.
>
> It makes good sense to do the refactoring in place, at first. Splitting
> the {smb1,cifs}*.[ch] files will be more complex, but maybe easier to
> review and merge, without folding in a new directory tree and git rm/mv.
> Either way, there will be at least two modules, maybe three if we split
> out generic subroutines.

Yes, Tom's points make sense.  The initial goal is to modularize the
smb1 (cifs) code,
and first goal is to do the refactoring in place without creating a
new directory
tree, allowing more and more of the smb1 code to be split out (currently
we can save about 10% on the module size when built with legacy disabled, but
I suspect that it will be about double that as more smb1 code is moved into
ifdefs or the smb1 specific c files).


-- 
Thanks,

Steve
