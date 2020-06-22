Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69DB202F6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 07:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgFVFSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 01:18:21 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:60565 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725934AbgFVFSU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 01:18:20 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 5C10817ED;
        Mon, 22 Jun 2020 01:18:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 22 Jun 2020 01:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=from
        :to:cc:subject:references:date:in-reply-to:message-id
        :mime-version:content-type:content-transfer-encoding; s=fm2; bh=
        B1QN7e3TFPweg/5icigcXBvh8YQ0PuwcEnbEASlXYSQ=; b=MWUJRNSLvjm2T0dL
        h0VGoN9h9kzg+I8XSoGtT/k+Zw6sSRxS/RgMN02CAxFwj5JvPKzYj7C82qlFOJTQ
        oamZrqzgL8es8XR7q0nH3Urq3H7aH/zTT5oGsDgQpjZjU+XtlFhV5nidCA6CGt8W
        3v9byO6IiaT3blbiy10Z+Cw/ejDbiBqGkWNxTW5jex7YRSLm0dmdaJgoJNHDQ2X4
        4+8fNQtlsX3FBNz7zfIbOMEYW8YTYSqJhqIw1CnHT5AG6BhCCeDPuJtVEODJpFa8
        e8F1yoMAq6DI6h3gYEGWv9vYbh8Ic2VZooBAv38GK1/u9WTr/AWmuahytT3ACMbA
        oLwaHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=B1QN7e3TFPweg/5icigcXBvh8YQ0PuwcEnbEASlXY
        SQ=; b=aSD1NhNVFB0dA+ytl7knNFbv2BeLAwZdsZWavkqc8FzpWwHuRqSkFSW2E
        Gq5d6+4SeNmmciNs3hmy+5AmGtRIbZRG1dHtMGS1jfBsQOGFOmHH3z39rrIyR7ZY
        EKdzkJN7WKS4Pr00df7vELFEwVIpcoc86/D3b/XaVJsXNUmmE9gRBj1tD1Z3YAM1
        pXDRFfcpfi0T5SUU8Lw0uQ0Peqk0vu5YMJooOpHkEKD49cQEiZzkphusZ688gyr+
        PEtIpt/OosuHv5UidOlV11+JWLG3bik8sFGpW6vDZt1bYPoeAg29rMcn8HI8zw/v
        2ncYxpMj9lwgkFXuMnOV5syeQ5Jvw==
X-ME-Sender: <xms:Gj_wXqB9FMg_ZKYcy9Jbm9zsgeJ7IWwnx7GgyGfs-P2La7EaxcOxcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudekuddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufhfffgjkfgfgggtgfesthhqtddttderjeenucfhrhhomheppfhikhho
    lhgruhhsucftrghthhcuoefpihhkohhlrghushesrhgrthhhrdhorhhgqeenucggtffrrg
    htthgvrhhnpefhteeugeehuddtfeetgedugfejhfeftdfhheeggeekjeeuveeileejtdef
    feffheenucfkphepudekhedrfedrleegrdduleegnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheppfhikhholhgruhhssehrrghthhdrohhrgh
X-ME-Proxy: <xmx:Gj_wXkhZDXGWcmXbNdQbu7Brt4VgdTsY-k1WuKgfvFTxvHyV8T0gIA>
    <xmx:Gj_wXtkLptaJciG0Ilj-TA7nQdqUeoKEZ6AnaakW20t1BvSkvCeyIA>
    <xmx:Gj_wXoxtR_LXObz6Abj6MmnGtxz9mHztJq_wxdvOknZwMQZM8Ew50g>
    <xmx:Gz_wXuGKHI7r6I5qe4ZMPNXYcpKWWKzkJFOPZjy5XVTcStYTP73kgQ>
Received: from ebox.rath.org (ebox.rath.org [185.3.94.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3731A3280060;
        Mon, 22 Jun 2020 01:18:18 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id 5D4595F;
        Mon, 22 Jun 2020 05:18:17 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id 37A50E29F9; Mon, 22 Jun 2020 06:18:17 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc:     dhowells@redhat.com, ebiggers@google.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        "p.kramme\@profihost.ag" <p.kramme@profihost.ag>,
        Daniel Aberger - Profihost AG <d.aberger@profihost.ag>
Subject: Re: Kernel 5.4 breaks fuse 2.X nonempty mount option
References: <736d172c-84ff-3e9f-c125-03ae748218e8@profihost.ag>
Mail-Copies-To: never
Mail-Followup-To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        dhowells@redhat.com, ebiggers@google.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, "p.kramme\@profihost.ag"
        <p.kramme@profihost.ag>, Daniel Aberger - Profihost AG
        <d.aberger@profihost.ag>
Date:   Mon, 22 Jun 2020 06:18:17 +0100
In-Reply-To: <736d172c-84ff-3e9f-c125-03ae748218e8@profihost.ag> (Stefan
        Priebe's message of "Thu, 18 Jun 2020 22:38:25 +0200")
Message-ID: <87pn9rsmp2.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Jun 18 2020, Stefan Priebe - Profihost AG <s.priebe@profihost.ag> wrote:
> Hi,
>
> while using fuse 2.x and nonempty mount option - fuse mounts breaks
> after upgrading from kernel 4.19 to 5.4.

IIRC nonempty is not processed by the kernel, but libfuse. This sounds like
you did a partial upgrade to libfuse 3.x (which dropped the option).

Best,
Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
