Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29493998D2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 06:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhFCEG3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 00:06:29 -0400
Received: from mail2.directv.syn-alias.com ([69.168.106.50]:32075 "EHLO
        mail.directv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhFCEG2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 00:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; d=wildblue.net; s=20170921; c=relaxed/simple;
        q=dns/txt; i=@wildblue.net; t=1622693084;
        h=From:Subject:Date:To:MIME-Version:Content-Type;
        bh=gZ/tdZFo6QJ/d0A1WUlyqMVYJEk=;
        b=tD/dSfYlk3uQL/44AF7GpzNCj7jYb1M1nE2+p7SBko3r/enkglV+MkuPRzYzGsio
        2ORrxPKHYbguv7IsMgZJS7izQ82MfshAEzMMZVTmWlFlAzUdzMYxrOQ478F7ns/O
        puO/p0ycfw+NbpOho4aZkzM7shSHhjbT76TlVqDwEcCiTkR+uywGXy0YiFT14LO2
        an0uQCWbX7K7axBAjP/jnshRZHIm9ah1fzXQ2WHoQVWuOaIXE//6fqls5oReaBA8
        JKkhdxQK0vl7t8ZeN1Ptfrl0LmUY03XIZtY6GpnpLuQAggxLtRiKMXpms54nvfGs
        Z3+x77DdTgbXw/TbPEHpYQ==;
X-Authed-Username: c29yb21uZXlAd2lsZGJsdWUubmV0
Received: from [10.80.118.0] ([10.80.118.0:56400] helo=md04.jasper.bos.sync.lan)
        by mail2.directv.syn-alias.com (envelope-from <soromney@wildblue.net>)
        (ecelerity 3.6.25.56547 r(Core:3.6.25.0)) with ESMTP
        id AF/0B-26161-BD458B06; Thu, 03 Jun 2021 00:04:43 -0400
Date:   Thu, 3 Jun 2021 00:04:43 -0400 (EDT)
From:   Rowell Hambrick <soromney@wildblue.net>
Reply-To: rowellhbm1@gmail.com
To:     huang_yingni@mfa.gov.cn
Message-ID: <381476663.107781519.1622693083033.JavaMail.zimbra@wildblue.net>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [45.152.183.12]
X-Mailer: Zimbra 8.7.6_GA_1776 (zclient/8.7.6_GA_1776)
Thread-Index: QQD6wUBUdSF98KmnxZK8snDTgKFpiQ==
Thread-Topic: 
X-Vade-Verditct: clean
X-Vade-Analysis: gggruggvucftvghtrhhoucdtuddrgeduledrvdelkedgjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuufgjpfetvefqtfdpggfktefutefvpdfqfgfvnecuuegrihhlohhuthemuceftddunecugfhmphhthicushhusghjvggtthculddutddmnecujfgurhepfffhrhfvkffugggtgfhiofhtsehtjegttdertdejnecuhfhrohhmpeftohifvghllhcujfgrmhgsrhhitghkuceoshhorhhomhhnvgihseifihhluggslhhuvgdrnhgvtheqnecuggftrfgrthhtvghrnhepfefhgefghfeihfdvleevhfelffdtgfeuudeihfevveelieeuvdegtdfhieffjeeunecukfhppedutddrkedtrdduudekrddtpdeghedrudehvddrudekfedruddvnecuvehluhhsthgvrhfuihiivgepleenucfrrghrrghmpehinhgvthepuddtrdektddruddukedrtddphhgvlhhopehmugdtgedrjhgrshhpvghrrdgsohhsrdhshihntgdrlhgrnhdpmhgrihhlfhhrohhmpehsohhrohhmnhgvhiesfihilhgusghluhgvrdhnvghtpdhrtghpthhtoheplhhiqhhirghnjhgrnhgvseduieefrdgtohhmpdhhohhsthepshhmthhprdhjrghsphgvrhdrsghoshdrshihnhgtrdhlrghnpdhsphhfpehsohhfthhfrghilhdpughkihhmpe
X-Vade-Client: VIASAT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Did you get my message
