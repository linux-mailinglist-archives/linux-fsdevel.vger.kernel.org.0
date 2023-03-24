Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D026C8882
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 23:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjCXWmu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 18:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjCXWms (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:42:48 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94151199F4;
        Fri, 24 Mar 2023 15:42:47 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 73E213200981;
        Fri, 24 Mar 2023 18:42:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 24 Mar 2023 18:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1679697766; x=1679784166; bh=/k
        G3Is5UEmDRGP5oqsqcd7AP1D5atjOd1Y4XPuwuxCg=; b=UDGXSuNdr6lxmHSUFQ
        CEesjboO8cSUJRDC0fwZI1xJw18cxwrM9RNoXmQYel7i/fNM85xAJU1WMGnkrGmg
        fboAh99Jv74VQghaFosRTnXS89jRsaszHoi1pn6iaztJ8nNz3qh1XG2Od+dscNQh
        O2T0WBPbxvMu+RFVMC1UatyGxGOZDjExxaW4adqr8hLesd6a2tiT8klTUsPhGRp8
        eg0AxBTyOWfagIH89SryBHyMfq3T4FNi0EUkTa5F1Y+y/v//87qEYFK4wc7723VO
        6Ep04icFHnY9z5J5zk8HRWDMoUurhng6OnMI8me9KIDP2fG2olS+hA2+bzjwjM8x
        CGcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679697766; x=1679784166; bh=/kG3Is5UEmDRG
        P5oqsqcd7AP1D5atjOd1Y4XPuwuxCg=; b=EH/ruGD4Dc1Sspuwenr2AMb5W0BvD
        Oqt+bynV8buoYrfyavz7gt5T+ifrySbmRBy7iO1sXluyjYfR6bGheazPObiLx2/l
        QmaikoawbJhZh/SpMPQMDAY6UpMgKFa54VW90TCz+pzNkceo44hPeATP0D434333
        Y6nzEgW6ab8M9hBkAQzFWPnxBNKHPE4fA3c/MfS9751VwATzzOvmSnQzF5TKChZV
        23nvPtzvHaI6lkR2GPK7U6fIRnIbkuv6hgQ3PqtaFP8W8PtorPZtL/ww+3eeBCeG
        uqLnCMHRRiVwXAboX93GFdsf9HGfHXFQimXd3XNKL1rjLL74BNt0wW6AA==
X-ME-Sender: <xms:ZSceZNiJay37E7-l57P9fDVCRjpgJc9oKh5cWcGy03tPHR_SFAxTVg>
    <xme:ZSceZCDdt5931xztthBBExDkeKazltYQQtPohx4L9ywdfNn2y-CFYXCRxYNA4yIST
    4a2eH72g_dHXSKcuzQ>
X-ME-Received: <xmr:ZSceZNE-1MLRHHat6sKkoui-5hDO8JTKA6j8a0vZs9pzHIphj21f5Gwt_oCYsGcpazJZoCVBXf36vzLcJoEw8LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegjedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefvhihlvghrucfjihgtkhhsuceotghouggvsehthihhihgt
    khhsrdgtohhmqeenucggtffrrghtthgvrhhnpedvhedvtddthfefhfdtgfelheefgefgud
    ejueevkeduveekvdegjedttdefgfelieenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegtohguvgesthihhhhitghkshdrtghomh
X-ME-Proxy: <xmx:ZSceZCTxXRB3Lrxw-c25FyeafRp52611ehUXVnWHr3L3SXtR7os03w>
    <xmx:ZSceZKzIGSCV1CdZhCe6TXDsVsVYq_iNl3ZK2Z7twrBx9WnNFdMSug>
    <xmx:ZSceZI6Vu3x7HpGZnIgUQhl_F7iGAenGveNxLXttmlnkTVrWGVKZFw>
    <xmx:ZiceZO_eP0ssD5lveL0XiS0L23slOdYCiJV98oLGX_2qBRJ9qQ45Dg>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Mar 2023 18:42:45 -0400 (EDT)
Date:   Fri, 24 Mar 2023 17:42:43 -0500
From:   Tyler Hicks <code@tyhicks.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: mark ecryptfs as orphan state
Message-ID: <ZB4nYykRg6UwZ0cj@sequoia>
References: <ZBlQT2Os/hB2Rxqh@kroah.com>
 <20230322171910.60755-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322171910.60755-1-frank.li@vivo.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-03-23 01:19:10, Yangtao Li wrote:
> +cc code@tyhicks.com, ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org

Hey Yangtao - I think it is a good idea to deprecate eCryptfs and
prepare for its removal in a couple years.

It never received the dedication needed to sort out the stacked
filesystem design issues and its crypto design is aging without
updates/improvements for some time. The majority of the user base, which
came about when Ubuntu added home dir encryption as an option in the
installer, has greatly decreased since Ubuntu removed it from the
installer and dropped official support several years back. Finally,
fscrypt should provide a more than complete alternative for the majority
of use cases.

Deprecating and removing is the right thing to do.

I can devote some time to limping it by until removal but would also
appreciate a hand if anyone has time/interest.

Tyler

> 
> Thx,
> Yangtao
