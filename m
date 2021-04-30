Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00529370043
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 20:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhD3SOY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 14:14:24 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:35349 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229990AbhD3SOX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:14:23 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id AF5031CFC
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 14:13:34 -0400 (EDT)
Received: from imap10 ([10.202.2.60])
  by compute1.internal (MEProxy); Fri, 30 Apr 2021 14:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=9FkpVFtVYjftxehfo/bHXT+QOagcZ
        gBWAhkr0phylI0=; b=ggBVsFrQpHTudqaFMGl3lhLxgESTGhn/UZ8t72GB4Pe7K
        SwjmOegF6vf74TS49DTlh5hgV2gE9rkQ/mqkAYLjiJmagJxkyN69ROrMj/Q+cY/g
        YBF7KM+mFujlv78IzpjOuqzwt0UD58coYs9H1OvA5Zmuhl0HNXdA6+ZoTAdYBA7R
        c7jVqKUEgWpipL9X8ybfsLwxDgAlNYWAM/R20eVMdmIRteIsSzMiRiTBtEKQuymF
        T8hAiesZaH9fAdmOpkI9gHyp8+dDPkrmHOZwRwRzlmBnQxciX4HThVByp8oyjxhD
        Rc8VkUN9a0Hneoaf8ru30boeS+EceUV02OZWSYvAg==
X-ME-Sender: <xms:zkiMYAGohNN96HQgoq7G4sOwh1BZnqCgd8k-Hi4epJtCbqQPYMavxg>
    <xme:zkiMYJWKTkU7bOvQxeNmwTm00LO7qx3ENBciii15Jgu6Ba167kBBBeOdhaaMM40YC
    wLVyNxIyXPA4WmD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddviedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgesthdtre
    dtreertdenucfhrhhomhepfdevohhlihhnucghrghlthgvrhhsfdcuoeifrghlthgvrhhs
    sehvvghrsghumhdrohhrgheqnecuggftrfgrthhtvghrnhepvdefleeggeejgeeugfevhe
    efueelueelvdeulefgudeugfelvdevhefhudduudetnecuffhomhgrihhnpehlfihnrdhn
    vghtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfi
    grlhhtvghrshesvhgvrhgsuhhmrdhorhhg
X-ME-Proxy: <xmx:zkiMYKI3rwGtYmzeozwQM70g-0XDLG_n556RTEv6MM7ZSMh3rLt1kQ>
    <xmx:zkiMYCGo0S2bzZ-IEih4Rjhh0gI7-lSSn21wMtXQqzBGGBe8UFdsUQ>
    <xmx:zkiMYGUAArib8COX4xeR3zVtYP3U7-qz67VIljcoUcqQN_Av9NnwAQ>
    <xmx:zkiMYPUTKSBQxgWd7d-JneVm8oZqFdXjZ5tp6iHgQ0aaIFH-CDJwhQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 07D694E00B9; Fri, 30 Apr 2021 14:13:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-403-gbc3c488b23-fm-20210419.005-gbc3c488b
Mime-Version: 1.0
Message-Id: <86c6332c-3c06-4bbf-baa5-67716d5e5b38@www.fastmail.com>
Date:   Fri, 30 Apr 2021 14:13:13 -0400
From:   "Colin Walters" <walters@verbum.org>
To:     linux-fsdevel@vger.kernel.org
Subject: exposing i_version to userspace?
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

AFAICS there's no way to get `i_version` from userspace?  

I'd swear this was one of the original goals of statx() and the notes in https://lwn.net/Articles/707602/ say "including generation and version numbers" but that apparently never happened?  Is there a reason why not?

I tried to search in the archives for this but the keywords I could think of around "stat" and "version" had too many other hits.

(Motivated by hitting some timestamp granularity issues in a synthetic test case for file time changes; if we could compare i_version instead that race would go away)
