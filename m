Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1E8724D2D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 21:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239209AbjFFThk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 15:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239072AbjFFThi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:37:38 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4826F10FB;
        Tue,  6 Jun 2023 12:37:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 097CB5C00D2;
        Tue,  6 Jun 2023 15:37:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 06 Jun 2023 15:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1686080253; x=1686166653; bh=NTnXhnoqb0BYacM6NQK+0UgwTN4rdTNC2WS
        g2wWyOQw=; b=KDIpHOMO3ve/dRhLkpSiLam6SZCCPR8zvN+r5nqpK5JWykfWjw8
        zgz+gTbTElyRHDsJLTllZf3Gp8wOniUlGeZc5QYi4EjqTDtxB9utSq8f7Z/hcOaY
        UJ5WQvRdtCYeXQVQREGnGiiH2y/XJRacUqii72ahOrXeYGKU4H+1BM7YZJUd6JZ/
        SKsy8+T3Wunmbtb0nmPqD3z+AXSRoX3jtrV3LUBAAjBsY/BwCYy6qSxlAncyMMjU
        BN2vKrzh6eny1u17h8nObe/jgEqMKg+rCnP2FR+8qxq/vGQ4t8B4ZYaKlKTcRsnc
        oVJPjW/mzigfvTZUfASYsfAIuIUx8DNa08g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1686080253; x=1686166653; bh=NTnXhnoqb0BYacM6NQK+0UgwTN4rdTNC2WS
        g2wWyOQw=; b=Pb7xpZTKp0qAtM9JJOAb8bDSiEVJaAvb2rmLl1qNaLPSROmUQzQ
        XXGI2+4BuMf+9d9WVbBa23h74PBRLGGfWMoE5AMTluWIlJuCCTiWjWy+pP8OvEEj
        hapxarEYOo+8B8fqeviRm+B42MMT9YTjiH5a5HtvHVS7XPElA6gFPSuTGtF7fQYy
        L9Pm5jqbT9QLRrLfhUMB8JPsM3LsBGFeFau44gsolpFuksJKAWhrsiPexz+jcSqW
        9bQaiwXUsYTpQHvf+nfypW3z8y7Cxrmd5wfW9+9MGH4Gci55Deeg6lOCAyInjssG
        Uzbu3Iq/OeR86rCP/UZRUIYBDL97JsFVjyw==
X-ME-Sender: <xms:_Ip_ZAmmcBfcnoh1bDe0awhgOzNSdUfBxNlGVNsKJIsIsnsTkBf-jg>
    <xme:_Ip_ZP3jZFYU_rzpGvy29ko9eSxcjIPoH0oz48kx2v9L-FAEGPapITLgxXmHqYVmZ
    _3zNcBs9v3VOvo7>
X-ME-Received: <xmr:_Ip_ZOq4ZvjZZDykLNtDtMEYrtIkjl9g96VpoKyhX7i4P5pzI28ARYgeK59yMaJ_KtBNfpfmwd4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtuddgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufhfffgjkfgfgggtgfesthhqtddttderjeenucfhrhhomheppfhi
    khholhgruhhsucftrghthhcuoefpihhkohhlrghushesrhgrthhhrdhorhhgqeenucggtf
    frrghtthgvrhhnpeetheettdduieelvdfhteeglefhudffteejieetjeelhfetuedvvddu
    fffggeeuudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheppfhikhholhgruhhssehrrghthhdr
    ohhrgh
X-ME-Proxy: <xmx:_Ip_ZMljerb6om3cPvdvgtHeErbQn8yn0spTowK87euy8qbj343xfg>
    <xmx:_Ip_ZO3WUi--80yqPPIDFvQhHs_Rc5JoC25V-kkNE7S7K3zurolmCw>
    <xmx:_Ip_ZDsNwbzhP3ksuL8lVdKV1N00UdWtLA7crbgiItry2Ugwf7u5RA>
    <xmx:_Yp_ZMwIBP5Xw60godatwahAtZQ6qj15HiNVBfCZkSsVlW-nboBBtw>
Feedback-ID: i53a843ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 15:37:32 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id A43A09D9;
        Tue,  6 Jun 2023 19:37:30 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id B37FAD0251; Tue,  6 Jun 2023 21:37:29 +0200 (CEST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Miklos Szeredi via fuse-devel <fuse-devel@lists.sourceforge.net>
Cc:     Askar Safin <safinaskar@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>, linux-pm@vger.kernel.org,
        Bernd Schubert <bernd.schubert@fastmail.fm>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [fuse-devel] [PATCH 0/6] vfs: provide automatic kernel freeze /
 resume
References: <CAPnZJGDWUT0D7cT_kWa6W9u8MHwhG8ZbGpn=uY4zYRWJkzZzjA@mail.gmail.com>
        <CAJfpeguZX5pF8-UNsSfJmMhpgeUFT5XyG_rDzMD-4pB+MjkhZA@mail.gmail.com>
Mail-Copies-To: never
Mail-Followup-To: Miklos Szeredi via fuse-devel
        <fuse-devel@lists.sourceforge.net>, Askar Safin
        <safinaskar@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
        linux-pm@vger.kernel.org, Bernd Schubert <bernd.schubert@fastmail.fm>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 06 Jun 2023 20:37:29 +0100
In-Reply-To: <CAJfpeguZX5pF8-UNsSfJmMhpgeUFT5XyG_rDzMD-4pB+MjkhZA@mail.gmail.com>
        (Miklos Szeredi via fuse-devel's message of "Tue, 6 Jun 2023 16:37:51
        +0200")
Message-ID: <871qiopekm.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Jun 06 2023, Miklos Szeredi via fuse-devel <fuse-devel@lists.sourceforge=
.net> wrote:
> On Sun, 14 May 2023 at 00:04, Askar Safin <safinaskar@gmail.com> wrote:
>>
>> Will this patch fix a long-standing fuse vs suspend bug? (
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D34932 )
>
> No.
>
> The solution to the fuse issue is to freeze processes that initiate
> fuse requests *before* freezing processes that serve fuse requests.
>
> The problem is finding out which is which.  This can be complicated by
> the fact that a process could be both serving requests *and*
> initiating them (even without knowing).
>
> The best idea so far is to let fuse servers set a process flag
> (PF_FREEZE_LATE) that is inherited across fork/clone.

Is that the same as what userspace calls PR_SET_IO_FLUSHER? From
prctl(2):

   PR_SET_IO_FLUSHER (since Linux 5.6)
          If a user process is involved in the block layer or filesystem I/=
O  path,  and
          can allocate memory while processing I/O requests it must set arg=
2 to 1.  This
          will put the process in the IO_FLUSHER state, which allows it  sp=
ecial  treat=E2=80=90
          ment  to make progress when allocating memory. [..]

          The calling process must have the CAP_SYS_RESOURCE capability.[..=
.]

          Examples  of  IO_FLUSHER  applications are FUSE daemons, SCSI dev=
ice emulation
          daemons, and daemons that perform error handling like multipath p=
ath  recovery
          applications.
=20=20=20=20=20=20=20=20=20=20

To me this sounds like it captures the relevant information (process is
involved in filesystem I/O) rather than just a preferred behavior (flush
late) and may thus be a better choice...

Best,
-Nikolaus
