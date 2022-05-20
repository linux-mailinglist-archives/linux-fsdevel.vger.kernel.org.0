Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C8652E3F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 06:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345345AbiETEnJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 00:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241873AbiETEnH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 00:43:07 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3681D12FEE5;
        Thu, 19 May 2022 21:43:06 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 14so64958qkl.6;
        Thu, 19 May 2022 21:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HxXmHtXAOQhVVUfS3L3OoqNmP4CeWfVkn39KC8Os63I=;
        b=ODl0/m/W1Q/V0f06/LDLNnljyyMDrLTaGET25hM+Oqhm1ve2P7FXmPgoLTFCMUVtH7
         tGWchpAlpfnRiZmlbb1xqJcHPKoq+5Ja+TJAvCA+mOcBrt+6bIHba1I2LobM632PtxLG
         UsVxuSKkIiTxnMzIwu5kJ7fKhbjeaT7S10dAytF+cd3S6yeGXt6OvU5PoWfTiJGQbBRz
         YNBjXHR6PYcgdqG8n2O92uVJxth6gz7sWtnYEiUqQPlRBlcAXE7ATyrNuUfxu63h5/cu
         prsPgVAn5S3YnrLhJFT3lBLNHCtwfOS+uqlrWJjUtDP0eyuauMyIt9kkBemJFdDzEM9E
         XKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HxXmHtXAOQhVVUfS3L3OoqNmP4CeWfVkn39KC8Os63I=;
        b=giLC0ms0fLyd4zgi5mcVuhSMDldRilP2KQn49MXTa8B6oNac3lX0AM7eLGfbH3Va6k
         hOe8whCeA0XHKnuiFx9LQe53neXlNm9crzQwSWdL6BywulSdBaRmMmboQBT70PfDOKqH
         nv5I/Msie+WkX9+JewhaLx9B7g1sCFAIBfEWFvnWFVzgAFC053MYcgawAFlBjiqQrnfA
         GRwqFacN1NNABq8oiASIrp7stw8arWVSn8dhECG+Xq20RFbRbVAuZ1UKJmBRXQfelS/k
         sre3Ld0uld7bog5uGQy/g3Hey5sUAy1SnTlb7xYmUR5jl0GVu4ERkVPgsBf2/iSAAMjJ
         lCzA==
X-Gm-Message-State: AOAM533FPzQwOZp5RyjhTVvtrRbhdjEaPHT2/fC1wYvBLXH8seAXfe9g
        VRCxSPeOsIrw3Y4ARM/xnDrjpIgbbotuZpdOSm8=
X-Google-Smtp-Source: ABdhPJwuraC+RsZo9ZixuIhu/ADf8GMM2yIGxMn0ogISrxVjLBP6dAmvpbxZu+GnY0UB7IjdAJmGTrK1HzU3x45Sfw0=
X-Received: by 2002:a05:620a:1aa0:b0:6a0:a34:15e0 with SMTP id
 bl32-20020a05620a1aa000b006a00a3415e0mr5284152qkb.19.1653021785174; Thu, 19
 May 2022 21:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20f17f64-88cb-4e80-07c1-85cb96c83619@windriver.com>
 <CAOQ4uxiQTwEh3ry8_8UMFuPPBjwA+pb8RLLuG=93c9hYtDqg8g@mail.gmail.com>
 <87czg94msb.fsf@brahms.olymp> <d6a2a914-fd1d-b00a-13d4-94ee1ff5b6fd@windriver.com>
In-Reply-To: <d6a2a914-fd1d-b00a-13d4-94ee1ff5b6fd@windriver.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 20 May 2022 07:42:53 +0300
Message-ID: <CAOQ4uxi-30=YjvK9ZkxDxr6jwjwAZ9x24tnHMk_mUGdB3+xPAA@mail.gmail.com>
Subject: Re: warning for EOPNOTSUPP vfs_copy_file_range
To:     He Zhe <zhe.he@windriver.com>
Cc:     =?UTF-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>,
        Dave Chinner <dchinner@redhat.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Luis Henriques <lhenriques@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 20, 2022 at 6:03 AM He Zhe <zhe.he@windriver.com> wrote:
>
>
>
> On 5/19/22 22:31, Lu=C3=ADs Henriques wrote:
> > Amir Goldstein <amir73il@gmail.com> writes:
> >
> >> On Thu, May 19, 2022 at 11:22 AM He Zhe <zhe.he@windriver.com> wrote:
> >>> Hi,
> >>>
> >>> We are experiencing the following warning from
> >>> "WARN_ON_ONCE(ret =3D=3D -EOPNOTSUPP);" in vfs_copy_file_range, from
> >>> 64bf5ff58dff ("vfs: no fallback for ->copy_file_range")
> >>>
> >>> # cat /sys/class/net/can0/phys_switch_id
> >>>
> >>> WARNING: CPU: 7 PID: 673 at fs/read_write.c:1516 vfs_copy_file_range+=
0x380/0x440
> >>> Modules linked in: llce_can llce_logger llce_mailbox llce_core sch_fq=
_codel
> >>> openvswitch nsh nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_de=
frag_ipv4
> >>> CPU: 7 PID: 673 Comm: cat Not tainted 5.15.38-yocto-standard #1
> >>> Hardware name: Freescale S32G399A (DT)
> >>> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> >>> pc : vfs_copy_file_range+0x380/0x440
> >>> lr : vfs_copy_file_range+0x16c/0x440
> >>> sp : ffffffc00e0f3ce0
> >>> x29: ffffffc00e0f3ce0 x28: ffffff88157b5a40 x27: 0000000000000000
> >>> x26: ffffff8816ac3230 x25: ffffff881c060008 x24: 0000000000001000
> >>> x23: 0000000000000000 x22: 0000000000000000 x21: ffffff881cc99540
> >>> x20: ffffff881cc9a340 x19: ffffffffffffffa1 x18: ffffffffffffffff
> >>> x17: 0000000000000001 x16: 0000adfbb5178cde x15: ffffffc08e0f3647
> >>> x14: 0000000000000000 x13: 34613178302f3061 x12: 3178302b636e7973
> >>> x11: 0000000000058395 x10: 00000000fd1c5755 x9 : ffffffc008361950
> >>> x8 : ffffffc00a7d4d58 x7 : 0000000000000000 x6 : 0000000000000001
> >>> x5 : ffffffc009e81000 x4 : ffffffc009e817f8 x3 : 0000000000000000
> >>> x2 : 0000000000000000 x1 : ffffff88157b5a40 x0 : ffffffffffffffa1
> >>> Call trace:
> >>>  vfs_copy_file_range+0x380/0x440
> >>>  __do_sys_copy_file_range+0x178/0x3a4
> >>>  __arm64_sys_copy_file_range+0x34/0x4c
> >>>  invoke_syscall+0x5c/0x130
> >>>  el0_svc_common.constprop.0+0x68/0x124
> >>>  do_el0_svc+0x50/0xbc
> >>>  el0_svc+0x54/0x130
> >>>  el0t_64_sync_handler+0xa4/0x130
> >>>  el0t_64_sync+0x1a0/0x1a4
> >>> cat: /sys/class/net/can0/phys_switch_id: Operation not supported
> >>>
> >>> And we found this is triggered by the following stack. Specifically, =
all
> >>> netdev_ops in CAN drivers we can find now do not have ndo_get_port_pa=
rent_id and
> >>> ndo_get_devlink_port, which makes phys_switch_id_show return -EOPNOTS=
UPP all the
> >>> way back to vfs_copy_file_range.
> >>>
> >>> phys_switch_id_show+0xf4/0x11c
> >>> dev_attr_show+0x2c/0x6c
> >>> sysfs_kf_seq_show+0xb8/0x150
> >>> kernfs_seq_show+0x38/0x44
> >>> seq_read_iter+0x1c4/0x4c0
> >>> kernfs_fop_read_iter+0x44/0x50
> >>> generic_file_splice_read+0xdc/0x190
> >>> do_splice_to+0xa0/0xfc
> >>> splice_direct_to_actor+0xc4/0x250
> >>> do_splice_direct+0x94/0xe0
> >>> vfs_copy_file_range+0x16c/0x440
> >>> __do_sys_copy_file_range+0x178/0x3a4
> >>> __arm64_sys_copy_file_range+0x34/0x4c
> >>> invoke_syscall+0x5c/0x130
> >>> el0_svc_common.constprop.0+0x68/0x124
> >>> do_el0_svc+0x50/0xbc
> >>> el0_svc+0x54/0x130
> >>> el0t_64_sync_handler+0xa4/0x130
> >>> el0t_64_sync+0x1a0/0x1a4
> >>>
> >>> According to the original commit log, this warning is for operational=
 validity
> >>> checks to generic_copy_file_range(). The reading will eventually retu=
rn as
> >>> not supported as printed above. But is this warning still necessary? =
If so we
> >>> might want to remove it to have a cleaner dmesg.
> >>>
> >> Sigh! Those filesystems have no business doing copy_file_range()
> >>
> >> Here is a patch that Luis has been trying to push last year
> >> to fix a problem with copy_file_range() from tracefs:
> >>
> >> https://lore.kernel.org/linux-fsdevel/20210702090012.28458-1-lhenrique=
s@suse.de/
> > Yikes!  It's been a while and I completely forgot about it.  I can
> > definitely try to respin this patch if someone's interested in picking
> > it.  I'll have to go re-read everything again and see what's missing an=
d
> > what has changed in between.
>
> Thank you both for quick replies.
>
> It would be good if this could be sorted out, as folks who are not famili=
ar with
> it might be confused by the call trace. But if this is supposed to cost a=
 long
> time, maybe we can first solve the false positive warning for the drivers=
 in this
> case, as it seems the "operational validity checks" was not for these dri=
vers.
>

Yes, technically, you are right.
Userspace should not be able to trigger a code validity assertion.
But the reason that assertion is there is to warn us developers
if we had overlooked a logic case and IMO we did.
The entire concept of calling ->copy_file_range() on random
filesystems has more than one problem and I would like for the kernel to
stop doing that.

Thanks,
Amir.
