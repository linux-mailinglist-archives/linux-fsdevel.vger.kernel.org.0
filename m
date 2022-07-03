Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E01564821
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jul 2022 16:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiGCOgt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 10:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGCOgs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 10:36:48 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31D363AB
        for <linux-fsdevel@vger.kernel.org>; Sun,  3 Jul 2022 07:36:47 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 78BF45C0067;
        Sun,  3 Jul 2022 10:36:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 03 Jul 2022 10:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1656859004; x=1656945404; bh=9sb6rt0Ya3
        RmOGuh36gCVHconvVIAJmML1ProfK4+Yk=; b=YKvzItZu1TBqCtFrhYNgERwvyE
        +9AZq3H9jH6nOqMnE05G5Icn7BFXMXgglyBJIso3G/afk+uJHaBlqJHrQCRfiNOB
        9Ssj7x2NNTP5e/G7VFCFuV6cUOoumG+VqCD8TO/bf3THcTADTt/wcZj4Lb6oLUwu
        Isdv6BtDdA833OddQJPaKmXRiWAT4AbiK+9po26ksPD5xGBNX791aSXHs7HiCxhm
        q3g1hIz4QqVW0HBKI3+OLI4ThpFT3dsI8fAAKRKi1tBsyYVsCM6q+giIZ44BuN5y
        abP5gCOOCFl1i8FZgCF2d56jLyXR3H/wbL4aeRGChy0skP2b0MR2ipL+Nyaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1656859004; x=1656945404; bh=9sb6rt0Ya3RmOGuh36gCVHconvVI
        AJmML1ProfK4+Yk=; b=CS7R7UYSQH10IoQ+sVzIRNBwZjhrF4N7uP9cLcFylHuU
        /aWw/DQ4aizROjdhNu+PI8q4b9E8I3TPoRBS0vq+AV3mDDPg2kz+ObCEcr05d4B9
        kvUoOmFua+zgp9hvqno8Y1zaSKVcMPaDlFBD19z/A6vemBirux4CWGEF2/Z6wi2J
        Ofy/MuSrnI+rXtjOSYsJSV59+8moZRVZi6pyrEKJVURQctVJEKwauGBojVLOqeLz
        6MMic0JnjvvbKrb9fYwj4EndGcECCKdG0MnL8dot8ZZ70XIoWEiy+N4LP4NE81Or
        8LksDNmB+iySp7NWOY6gt9Vjogdv6aBuR3RjVbabyw==
X-ME-Sender: <xms:fKnBYiREzafHGAwCOaEeBHiVwPuzYC1bJz2eQb9yoIuqI6eiYYK8zw>
    <xme:fKnBYnx3xC4jHkBi5L4OwHXW20gXiOjyWbIAxT7NEMkDlqLzq1nFdc78TAAHQsMeE
    YNyu4rabSAQMxjp>
X-ME-Received: <xmr:fKnBYv2fsBIZWu_hJpKSn-SHZfmiyXk39JitBdMlSMoEfuFGo91WIVWzicqJ_Ebv0N15LmiVDYs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehjedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfgfgggtgfesthhqtddttderjeenucfhrhhomheppfhikhholhgr
    uhhsucftrghthhcuoefpihhkohhlrghushesrhgrthhhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeeftefhgfejhfelkeduieeludeuffduvedvveefkeevtdevgeevfeejgfdvuedt
    keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpefpih
    hkohhlrghushesrhgrthhhrdhorhhg
X-ME-Proxy: <xmx:fKnBYuDYEM3JTiqnLlS5II1Bs2okpBcf7jCl8WIGTxQTTmwvdU394w>
    <xmx:fKnBYrhbyd0GQtMSCyqb2uVrJFyo8KiihsrU97hE8kVr9XOv6TmvyA>
    <xmx:fKnBYqr5qfWWApdlFPi2QqO1IedE4dwVT0SjcJulsvQ7YBd31Lt75w>
    <xmx:fKnBYreeJkW9ANMlnCHWbPqO6MfXWAYa9XnGClAytqCVee6vnvRzgg>
Feedback-ID: i53a843ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Jul 2022 10:36:43 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 85FE198C;
        Sun,  3 Jul 2022 14:36:42 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id 1A961682A4; Sun,  3 Jul 2022 15:36:42 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        miklos <mszeredi@redhat.com>
Subject: potential race in FUSE's readdir() + releasedir()?
Mail-Copies-To: never
Mail-Followup-To: Linux FS Devel <linux-fsdevel@vger.kernel.org>, fuse-devel
        <fuse-devel@lists.sourceforge.net>, miklos <mszeredi@redhat.com>
Date:   Sun, 03 Jul 2022 15:36:42 +0100
Message-ID: <87tu7yjm9x.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I am seeing something that to me looks like a race between FUSE's
readdir() and releasedir() handlers. On kernel 5.18, the FUSE daemon
seems to (ocasionally) receive a releasedir() request while a readdir()
request with the same `struct fuse_file_info *fi->fh` is still active
(i.e., the FUSE daemon hasn't sent a reply to the kernel for this yet).

Could this be a bug in the kernel? Or is there something else that could
explain this?

Best,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
