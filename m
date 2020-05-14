Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FA41D35F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 18:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgENQF1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 12:05:27 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:39678 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgENQF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 12:05:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E26F56224FD8;
        Thu, 14 May 2020 18:05:24 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id iM0G5GJMg53f; Thu, 14 May 2020 18:05:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C13216224FC5;
        Thu, 14 May 2020 18:05:23 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ee4XeyBIMuBh; Thu, 14 May 2020 18:05:23 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 99FC66224FD8;
        Thu, 14 May 2020 18:05:23 +0200 (CEST)
Date:   Thu, 14 May 2020 18:05:23 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        David Sterba <dsterba@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>
Message-ID: <1536293942.220013.1589472323477.JavaMail.zimbra@nod.at>
In-Reply-To: <20200514100018.1809465c@lwn.net>
References: <20200514092415.5389-1-jth@kernel.org> <20200514092415.5389-4-jth@kernel.org> <20200514062611.563ec1ea@lwn.net> <SN4PR0401MB3598FFE2AC30EA4E7B85533C9BBC0@SN4PR0401MB3598.namprd04.prod.outlook.com> <1363039146.219999.1589469276242.JavaMail.zimbra@nod.at> <20200514100018.1809465c@lwn.net>
Subject: Re: [PATCH v3 3/3] btrfs: document btrfs authentication
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: btrfs: document btrfs authentication
Thread-Index: gyZzhnsO+uH9PYLSiErl0f0A7VuQRA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Jonathan Corbet" <corbet@lwn.net>
> An: "richard" <richard@nod.at>
> CC: "Johannes Thumshirn" <Johannes.Thumshirn@wdc.com>, "Johannes Thumshirn" <jth@kernel.org>, "David Sterba"
> <dsterba@suse.cz>, "linux-fsdevel" <linux-fsdevel@vger.kernel.org>, "linux-btrfs" <linux-btrfs@vger.kernel.org>, "Eric
> Biggers" <ebiggers@google.com>
> Gesendet: Donnerstag, 14. Mai 2020 18:00:18
> Betreff: Re: [PATCH v3 3/3] btrfs: document btrfs authentication

> On Thu, 14 May 2020 17:14:36 +0200 (CEST)
> Richard Weinberger <richard@nod.at> wrote:
> 
>> But I have no idea what this orphan thingy is.
> 
> It suppresses a warning from Sphinx that the file is not included in the
> docs build.  Mauro did that with a lot of his conversions just to make his
> life easier at the time, but it's not really something we want going
> forward.

Ahh, thanks for explaining. :-)

Thanks,
//richard
