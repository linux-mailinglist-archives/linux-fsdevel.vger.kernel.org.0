Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA5D2F3D82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 01:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389329AbhALVlv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 16:41:51 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39415 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731253AbhALVhl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 16:37:41 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id DBAF05C01E9;
        Tue, 12 Jan 2021 16:36:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 12 Jan 2021 16:36:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=Uu763oWbJWYmCwQoS+PcRoadjyh
        lnHhoTiLxUdxm918=; b=lA1UaPCB1gWTWf+CMmIhzQfwi07esA2tt1zqzzodlg3
        1DOfvxgxJs47H/L2kbNrjbxYwxUycZjD5pC7GLx4bajbs0oQV9xGEJ4xVwh9oenI
        Xvl58bvx4YsJWa/sPXBDRgYdsa+y2+2YPhVVSkmBe4TwdCrgaSFs2KY/8IPtG/vy
        bBSbnHvdvrKT4mLTMXFAfBpjkP3+d929VKh5DQJdBXeOSkpAfzE48SyfJWzm6Bpc
        ClqAerYQlJxPRg24/pOdD0vqk1S8z+GJClvM6cLPFC2NeqXnI7o3lomWltj6511F
        rU+X90I+tX03QZhRsYlUXtFwyWQaFj1STj/whlkpCOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Uu763o
        WbJWYmCwQoS+PcRoadjyhlnHhoTiLxUdxm918=; b=mJekN6kYB/JUjM5fT8ncZj
        icaWeg+u9/5jX8VSNvMm/OtLvvrSkGG0Dffi5Xva5hf6s+0pMf6jjPjL4QSvSLSn
        OeuNPk4xJZbi2i8A71zKguK8S7Usq9QD2lCzl5P8pr8kltctTcldXDAdkAYmMG8e
        2ckyTfAZWekbL0Wq8xi+75zZnBotz40xlOzkIlm9+Um84jkChIy4dByKtwEKRj/J
        mKrSVuI9hsFNcgk0hemjQUo0m62U2gMDS3v9opTMsKtqZkuJxOHdXzUqsEqo9jG8
        dP720/zNhy1lAjIDNMhoNyATHv7VVehxZw0jgLQhS2JES4NNpeRCerxUc+hVquQA
        ==
X-ME-Sender: <xms:Yhb-X2DmtHXLrer6DIdB-u1vl1gglLVg1jOWQvApQ2ALJ5PHky9ZAQ>
    <xme:Yhb-Xwhzdo0brwwBkFlP9JwHbxksgfw5K-oRr17rR34cm9IQo-sZr8Z8j1063l-Xv
    kquJiGdttLiLSuuvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddtgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgurhgv
    shcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtffrrg
    htthgvrhhnpedukefhkeelueegveetheelffffjeegleeuudelfeefuedtleffueejfffh
    ueffudenucfkphepieejrdduiedtrddvudejrddvhedtnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvghssegrnhgrrhgriigvlhdr
    uggv
X-ME-Proxy: <xmx:Yhb-X5mCiJnfgBVpqLWfzux-iGGonByxB9KjAbWyDZGvei-yuq5KJg>
    <xmx:Yhb-X0x9ZFwH5BmVOVTz_WVsyYZBUMCdZJGl480V6HzI0kkTn6UC-g>
    <xmx:Yhb-X7Rlr0UYUgMPY9OkBQbDx18ZlFTB3gmgpajoWCeRPhkoPwgoJw>
    <xmx:Yhb-X8IsQVdVYdQcHf33Snrrc1I3YuwjpTNgtTcM9HM6li37YBsPZQ>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7D3831080057;
        Tue, 12 Jan 2021 16:36:34 -0500 (EST)
Date:   Tue, 12 Jan 2021 13:36:33 -0800
From:   Andres Freund <andres@anarazel.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Avi Kivity <avi@scylladb.com>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: fallocate(FALLOC_FL_ZERO_RANGE_BUT_REALLY) to avoid unwritten
 extents?
Message-ID: <20210112213633.fb4tjlgvo6tznfr4@alap3.anarazel.de>
References: <20201230062819.yinrrp6uwfegsqo3@alap3.anarazel.de>
 <20210104181958.GE6908@magnolia>
 <20210104191058.sryksqjnjjnn5raa@alap3.anarazel.de>
 <f6f75f11-5d5b-ae63-d584-4b6f09ff401e@scylladb.com>
 <20210112181600.GA1228497@infradead.org>
 <C8811877-48A9-4199-9F28-20F5B071AE36@dilger.ca>
 <20210112184339.GA1238746@infradead.org>
 <1C33DEE4-8BE9-4BF3-A589-E11532382B36@dilger.ca>
 <20210112211445.GC1164248@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112211445.GC1164248@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 2021-01-12 13:14:45 -0800, Darrick J. Wong wrote:
> ALLOCSP64 can only allocate pre-zeroed blocks as part of extending EOF,
> whereas a new FZERO flag means that we can pre-zero an arbitrary range
> of bytes in a file.  I don't know if Avi or Andres' usecases demand that
> kind of flexibilty but I know I'd rather go for the more powerful
> interface.

Postgres/I don't at the moment have a need to allocate "written" zeroed
space anywhere but EOF. I can see some potential uses for more flexible
pre-zeroing in the future though, but not very near term.

Greetings,

Andres Freund
