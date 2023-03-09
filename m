Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB4C6B25B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 14:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjCINp3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 08:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCINp2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:45:28 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912A55D744;
        Thu,  9 Mar 2023 05:45:25 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so3624616wmb.5;
        Thu, 09 Mar 2023 05:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678369524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6Yp4ykCm3cUFPIraj3jw8904oAl0ICbY5EFtxJP3RY=;
        b=kAgzbWBIm+8cm3CHxp+53SeTaQI1ayQTmGl++4bNxTad8rAMdhOr5AvIh1lNETh6HZ
         Uc9FrU3Fz6FpbYzVxo3JxTmZ2zx+k1nVRLvH71q/3hTX+6fV3l6MyQa5AAXYF7Z46JT2
         lHXdypnKmx5MuZLY98B+rGbcJgFo+oEHaWscv9A1E+LRQcvUkBHLD1QIZIPS7gLiSNY8
         asVRONWnX5toQG1I8WmEq6SsyJJqugq+m0LHCsN1vR97bVZBZGRl8j0bHZHSpEm0vf6q
         MXMWwYP9Pp7DfXEVdCtUZkwEpORqy3DPGn7+u8+sPbE3KExC1OhEswE7Td/WgZWCTuld
         bYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678369524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6Yp4ykCm3cUFPIraj3jw8904oAl0ICbY5EFtxJP3RY=;
        b=TXfnBKYpplZkIYYWwBnkRZAdQUcrV/VhHqk9+sCVE8J1O/KXOMZpQDH5ClIlDjQ/19
         PeCVknSEJ14HoTM9e9LduTAsteaCZm27IJS7cetdUkqZLDa06lR+BEI1HQho0PhWqVZo
         TVAAxruRfmUTktr1vLxWEXRTv1NAjoLepdRCDCZq5k5LQahxUWwOPtc7Ht007KAH1yap
         zr1J5rZ499L1ghl6kfe3c7Xxag25Tu7o4o0rJQs/pTorPjb3+7je//kFA6Tmtei+qCmd
         5wbZ+ephbY38wyBWKwTv/7P0wQFsPOroOBGNyD2ONHyyCI5lqetGdPkIvySOhkJsZ13g
         BZVQ==
X-Gm-Message-State: AO0yUKUm+mb0f/N1iCsqgNMOepijRIzxtlJrOAQ0goY0e6e4hv2B19NE
        1/GluAcjtGdhrd4LSmBnNrU=
X-Google-Smtp-Source: AK7set9o30O7lBn3u0olN/rw8q0yBl1RBDA+SlXQJiJaNfm57RCNKUNdegRH6uqAagMOIT4QE4LmDA==
X-Received: by 2002:a05:600c:3b22:b0:3e2:1d1e:78d6 with SMTP id m34-20020a05600c3b2200b003e21d1e78d6mr19656319wms.7.1678369523969;
        Thu, 09 Mar 2023 05:45:23 -0800 (PST)
Received: from suse.localnet (host-95-235-93-126.retail.telecomitalia.it. [95.235.93.126])
        by smtp.gmail.com with ESMTPSA id z17-20020a05600c221100b003e01493b136sm2769076wml.43.2023.03.09.05.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 05:45:23 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git sysv pile
Date:   Thu, 09 Mar 2023 14:45:22 +0100
Message-ID: <1812408.QZUTf85G27@suse>
In-Reply-To: <2907412.VdNmn5OnKV@suse>
References: <Y/gugbqq858QXJBY@ZenIV> <ZAD6n+mH/P8LDcOw@ZenIV> <2907412.VdNmn5OnKV@suse>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On mercoled=EC 8 marzo 2023 18:40:44 CET Fabio M. De Francesco wrote:
> On gioved=EC 2 marzo 2023 20:35:59 CET Al Viro wrote:
>=20
> [...]
>=20
> > Frankly, ext2 patchset had been more along the lines of "here's what
> > untangling the calling conventions in ext2 would probably look like" th=
an
> > anything else. If you are willing to test (and review) that sucker and =
it
> > turns out to be OK, I'll be happy to slap your tested-by on those during
> > rebase and feed them to Jan...
>=20
> I git-clone(d) and built your "vfs" tree, branch #work.ext2, without and=
=20
with
> the following commits:
>=20
> f5b399373756 ("ext2: use offset_in_page() instead of open-coding it as
> subtraction")
>=20
> c7248e221fb5 ("ext2_get_page(): saner type")
>=20
> 470e54a09898 ("ext2_put_page(): accept any pointer within the page")
>=20
> 15abcc147cf7 ("ext2_{set_link,delete_entry}(): don't bother with page_add=
r")
>=20
> 16a5ee2027b7 ("ext2_find_entry()/ext2_dotdot(): callers don't need page_a=
ddr
> anymore")
>=20
> Then I read the code and FWIW the five patches look good to me. I think t=
hey
> can work properly.
>=20
> Therefore, if you want to, please feel free to add my "Reviewed-by" tag (=
OK,=20
I
> know that you don't need my reviews, since you are the one who taught me =
how
> to write patches like yours for sysv and ufs :-)).
>=20
> As a personal preference, in ext2_get_page() I'd move the two lines of co=
de
> from the "fail" label to the same 'if' block where you have the "goto=20
fail;",
> mainly because that label is only reachable from there. However, it does =
not
> matter at all because I'm only expressing my personal preference.
>=20
> I ran `./check -g quick` without your patches in a QEMU/KVM x86_32 VM, 6GB
> RAM, running a Kernel with HIGHMEM64GB enabled. I ran it three or four ti=
mes
> because it kept on hanging at random tests' numbers.
>=20
> I'm noticing the same pattern due to the oom killer kicking in several ti=
mes
> to kill processes until xfstests its is dead.
>=20
> [ 1171.795551] Out of memory: Killed process 1669 (xdg-desktop-por) total-
vm:
> 105068kB, anon-rss:9792kB, file-rss:10972kB, shmem-rss:0kB, UID:1000=20
pgtables:
> 136kB oom_score_adj:200
> [ 1172.339920] systemd invoked oom-killer: gfp_mask=3D0xcc0(GFP_KERNEL),
> order=3D0, oom_score_adj=3D100
> [ 1172.339927] CPU: 3 PID: 1413 Comm: systemd Tainted: G S      W   E
> 6.3.0-rc1-x86-32-debug+ #1
> [ 1172.339929] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> rel-1.16.0-0-gd239552-rebuilt.opensuse.org 04/01/2014
> [ 1172.339931] Call Trace:
> [ 1172.339934]  dump_stack_lvl+0x92/0xd4
> [ 1172.339939]  dump_stack+0xd/0x10
> [ 1172.339941]  dump_header+0x42/0x454
> [ 1172.339945]  ? ___ratelimit+0x6f/0x140
> [ 1172.339948]  oom_kill_process+0xe9/0x244
> [ 1172.339950]  out_of_memory+0xf6/0x424
>=20
> I have not enough experience to understand why we get to that out-of-memo=
ry
> condition, so that several processes get killed. I can send the whole=20
decoded
> stack trace and other information to whoever can look at this issue to=20
figure
> out how to fix this big issue. I can try to bisect this issue too, but I=
=20
need
> time because of other commitments and a slow system for building the=20
necessary
> kernels.
>=20
> I want to stress that it does not depend on the above-mentioned patches.=
=20
Yes,
> I'm running Al's "vfs" tree, #work.ext2 branch, but with one only patch=20
beyond
> the merge with Linus' tree:
>=20
> 522dad1 ext2_rename(): set_link and delete_entry may fail
>=20
> I have no means to test this tree. However, I think that I'd have the same
> issue with Linus' tree too, unless this issue is due to the only commit n=
ot
> yet there (I strongly doubt about this possibility).
>=20
> Thanks,
>=20
> Fabio

I want to confirm that running xfstests on the most recent SUSE Kernel does=
n't=20
trigger the OOM Killer. It only fails 16 of 597 tests. I suppose that those=
 16=20
failures are expected to happen.

The kernel provided by openSUSE Tumbleweed is...

uname -a
Linux tweed32 6.2.1-1-pae #1 SMP PREEMPT_DYNAMIC Mon Feb 27 11:39:51 UTC 20=
23=20
(69e0e95) i686 athlon i386 GNU/Linux

I'll try a bisection as soon as possible.

=46abio


