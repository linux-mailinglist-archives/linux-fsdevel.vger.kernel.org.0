Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6F71C494E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 23:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgEDV7U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 4 May 2020 17:59:20 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:52546 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbgEDV7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 17:59:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 82AEB6071A61;
        Mon,  4 May 2020 23:59:17 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ORmgk83AKakw; Mon,  4 May 2020 23:59:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A74316071A7C;
        Mon,  4 May 2020 23:59:16 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YuWijWMN5XAw; Mon,  4 May 2020 23:59:16 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7DAC86071A61;
        Mon,  4 May 2020 23:59:16 +0200 (CEST)
Date:   Mon, 4 May 2020 23:59:16 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Johannes Thumshirn <jth@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        david <david@sigma-star.at>,
        Sascha Hauer <s.hauer@pengutronix.de>
Message-ID: <164471725.184338.1588629556400.JavaMail.zimbra@nod.at>
In-Reply-To: <20200428105859.4719-2-jth@kernel.org>
References: <20200428105859.4719-1-jth@kernel.org> <20200428105859.4719-2-jth@kernel.org>
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: btrfs: add authentication support
Thread-Index: Z3MnT0+k8n5OYo6is7pXVDYH2KOhKQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Johannes Thumshirn" <jth@kernel.org>
> An: "David Sterba" <dsterba@suse.cz>
> CC: "linux-fsdevel" <linux-fsdevel@vger.kernel.org>, "linux-btrfs" <linux-btrfs@vger.kernel.org>, "Eric Biggers"
> <ebiggers@google.com>, "richard" <richard@nod.at>, "Johannes Thumshirn" <johannes.thumshirn@wdc.com>, "Johannes
> Thumshirn" <jthumshirn@suse.de>
> Gesendet: Dienstag, 28. April 2020 12:58:58
> Betreff: [PATCH v2 1/2] btrfs: add authentication support

> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Add authentication support for a BTRFS file-system.
> 
> This works, because in BTRFS every meta-data block as well as every
> data-block has a own checksum. For meta-data the checksum is in the
> meta-data node itself. For data blocks, the checksums are stored in the
> checksum tree.

Eric already raised doubts, let me ask more directly.
Does the checksum tree really cover all moving parts of BTRFS?

I'm a little surprised how small your patch is.
Getting all this done for UBIFS was not easy and given that UBIFS is truly
copy-on-write it was still less work than it would be for other filesystems.

If I understand the checksum tree correctly, the main purpose is protecting
you from flipping bits.
An attacker will perform much more sophisticated attacks.

Thanks,
//richard
