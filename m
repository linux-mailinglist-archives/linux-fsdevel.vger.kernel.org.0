Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940F31C54E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 13:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgEEL4u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Tue, 5 May 2020 07:56:50 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:34666 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgEEL4t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 07:56:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0C0376075EB6;
        Tue,  5 May 2020 13:56:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6a91-kHTbc-Q; Tue,  5 May 2020 13:56:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 02A7760CEF4B;
        Tue,  5 May 2020 13:56:46 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KlCIGRGSqhZO; Tue,  5 May 2020 13:56:45 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id C496B60CEF2B;
        Tue,  5 May 2020 13:56:45 +0200 (CEST)
Date:   Tue, 5 May 2020 13:56:45 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        David Sterba <dsterba@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        david <david@sigma-star.at>,
        Sascha Hauer <s.hauer@pengutronix.de>
Message-ID: <1450548725.186388.1588679805599.JavaMail.zimbra@nod.at>
In-Reply-To: <SN4PR0401MB359805375970F69ED7BDD5379BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200428105859.4719-1-jth@kernel.org> <20200428105859.4719-2-jth@kernel.org> <20200501053908.GC1003@sol.localdomain> <SN4PR0401MB3598198E5FB728B68B39A1589BA60@SN4PR0401MB3598.namprd04.prod.outlook.com> <769963893.184242.1588628271082.JavaMail.zimbra@nod.at> <SN4PR0401MB359805375970F69ED7BDD5379BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: btrfs: add authentication support
Thread-Index: AQHWHUw3Fjk34p8J2kWvUrIfOj4HzXkTZJtq
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Johannes Thumshirn" <Johannes.Thumshirn@wdc.com>
> An: "richard" <richard@nod.at>
> CC: "Eric Biggers" <ebiggers@kernel.org>, "Johannes Thumshirn" <jth@kernel.org>, "David Sterba" <dsterba@suse.cz>,
> "linux-fsdevel" <linux-fsdevel@vger.kernel.org>, "linux-btrfs" <linux-btrfs@vger.kernel.org>, "david"
> <david@sigma-star.at>, "Sascha Hauer" <s.hauer@pengutronix.de>
> Gesendet: Dienstag, 5. Mai 2020 09:46:42
> Betreff: Re: [PATCH v2 1/2] btrfs: add authentication support

> On 04/05/2020 23:41, Richard Weinberger wrote:
>> Well, UBIFS stores auth_hash_name on disk but does not trust it.
>> It is always required to provide auth_hash_name as mount parameter.
>> At mount time it is compared to the stored name (among with other parameters)
>> to detect misconfigurations.
> 
> OK, thanks for the information.
> 
> Will do so as well in v3

With UBIFS this is now the second in-tree filesystem with authentication support.
IMHO it is worth adding a new statx flag to denote this. Just like we do already
for encrypted and verity protected files.
STATX_ATTR_AUTHED?

Especially for BTRFS user this is valubale information since BTRFS authentication
is incompatible with nodatacow'ed files/dirs/subvolumes. And it might be not obvious which files are
protected and which are not. 

Thanks,
//richard
