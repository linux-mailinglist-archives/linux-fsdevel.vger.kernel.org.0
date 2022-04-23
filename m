Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A09350CC61
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 18:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbiDWQos (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Apr 2022 12:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236473AbiDWQo3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Apr 2022 12:44:29 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789834B854
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Apr 2022 09:41:21 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 04E045C00B5
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Apr 2022 12:41:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 23 Apr 2022 12:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1650732078; x=1650818478; bh=KXkkKB7hBn
        wwAwei7Sq/5xXqvTv9GbxxXReqtj+3xK8=; b=BnpaoPOXWMriWBo3FgQkWe48Ir
        LJdc3/VcNk0rfQg7j9cjISFLEhjTgtQSOCMBB3wKOmUBIirMDf1P+jUPcZ42Jn/d
        2G50K5Mlofs4lN5KyWwVhe4aM/L+jJheREcDOPHOfGn75CxuxfFPfOnTNAHZTnmM
        ToE5uvtp6OVAL67cA4gtWZsh4blzvK23r792XzU2kfjwdHYhqPCYG+ij5BXlENpz
        OhkCZFUEnbBwE63/CLRfPLfC99apKL3MX0j8j2HnET7O6D3VAO2O+emepkCrgzNT
        k9HQ0wgGxnYVtpUEgcj11+wCZ8cVDR2wOuiXh7kjiw3KPpDT/GTTKMDrAflA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1650732078; x=
        1650818478; bh=KXkkKB7hBnwwAwei7Sq/5xXqvTv9GbxxXReqtj+3xK8=; b=l
        q9Q3N3Jcdp3OysdRu400gdLtZoVbrHm3cqjfQ3gwykfO6rMVJKHvoLqOuGH0Wa12
        M0VZiTDXM1ar/oahPgvmZtsyCxqAil1Y+qQtkw7Y3l0RTwNKHVuCxteYFeNV0g2A
        FT28xw0y3gN5ohN14q/WrkT6VL9RrXrzUO9n+tQ9W3NIR0xujrz2Ybcyjb4+6kD3
        bv2T1qW0Ci/Ymz/94qFS6ELGAecDDdHfB+KurVTo6zlyzVCesb7PuSvO5t9A7Lf8
        uJ4oAG92jnweohSFb38JSgmWN26uVXtDlb55FbBu4imfigHW188zPi0+OZkZdkVr
        vBP3oWXXXHRTxe2G7N0WQ==
X-ME-Sender: <xms:LixkYjhz_WFpuRLYzJCTN1GBsH-niLFDS14WWy2QdKYmkQkijlxgkw>
    <xme:LixkYgB7BH4ayCegz9XPUbU5M72LO24MnsZdwmCn589iUA2g5zc9Ee3XFCN3UDPkA
    9EpXBUSVn56Ffut>
X-ME-Received: <xmr:LixkYjG3ygljpYwZ3vTMs6cHgHyHk_tv6i57uiae8l0PBNW-s_6mhS_hhotVvv3jpwXLrEJV4Fc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdeigddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkfgfgggtgfesthhqtddttderjeenucfhrhhomheppfhikhholhgr
    uhhsucftrghthhcuoefpihhkohhlrghushesrhgrthhhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeeftefhgfejhfelkeduieeludeuffduvedvveefkeevtdevgeevfeejgfdvuedt
    keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpefpih
    hkohhlrghushesrhgrthhhrdhorhhg
X-ME-Proxy: <xmx:LixkYgRy9e8ZUlhpTcVc8sV6OgzwqO4TBFrtq4wWlVjb-PpeAjnFzQ>
    <xmx:LixkYgzo5H9kqmKHK1t0LlYJ9MaDlcIRzwA_58n0inuMjwcfJ6-Q-w>
    <xmx:LixkYm4x6PDTsI7IFaXmOMnYpo17ZeCTIhzJkbtnvzL1ADJaWvP0Qg>
    <xmx:LixkYr9qKGOxiNZLqvntSOGKwaCwJp36WZjpi5sjtV9P-z1HT9qoVw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-fsdevel@vger.kernel.org>; Sat, 23 Apr 2022 12:41:18 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 56F7588D
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Apr 2022 16:41:17 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id D7FC4C1FE6; Sat, 23 Apr 2022 17:41:16 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: fadvise(POSIX_FADV_DONTNEED) and huge pages
Mail-Copies-To: never
Mail-Followup-To: Linux FS Devel <linux-fsdevel@vger.kernel.org>
Date:   Sat, 23 Apr 2022 17:41:16 +0100
Message-ID: <87bkwrhhw3.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

posix_fadvise(2) tells me that when using POSIX_FADV_DONTNEED, "Requests
to discard partial pages are ignored. If the application requires that
data be considered for discarding, then offset and len must be
page-aligned.".

How does this interact with huge pages?

Is it sufficient to align with getpagesize()? Or do offset and len need
to be aligned with huge page offsets when the region is backed by a huge
page?

In the latter case, is there a way for userspace to ensure this?


Best,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
