Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA5F0A2AF9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 01:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfH2XfI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 19:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbfH2XfI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 19:35:08 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A0392173E;
        Thu, 29 Aug 2019 23:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567121707;
        bh=MyHmJUU3Gn2uuapEBmq5L4LI7DM7u2Evj0T5dUzngj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MbKkKKR0uyA41FC66Oo4hTRux8s83095GYUAliZ9zLkaKe7iz2b30Mi8EiHVPoF3q
         clZF0De+LYVO+xsNkIjkfxYgtwFaKjdINb7Y+oqJyLdMAB35Ic2zGoEYOPH7Ny5ELw
         TBILAOb2LwnxMigNkC8Cbk1WoUYTG/6qrjCEEQos=
Date:   Thu, 29 Aug 2019 19:35:06 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190829233506.GT5281@sasha-vm>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190829205631.uhz6jdboneej3j3c@pali>
 <184209.1567120696@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <184209.1567120696@turing-police>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 07:18:16PM -0400, Valdis Klētnieks wrote:
>On Thu, 29 Aug 2019 22:56:31 +0200, Pali Roh?r said:
>
>> I'm not really sure if this exfat implementation is fully suitable for
>> mainline linux kernel.
>>
>> In my opinion, proper way should be to implement exFAT support into
>> existing fs/fat/ code instead of replacing whole vfat/msdosfs by this
>> new (now staging) fat implementation.
>
>> In linux kernel we really do not need two different implementation of
>> VFAT32.
>
>This patch however does have one major advantage over "patch vfat to
>support exfat" - which is that the patch exists.
>
>If somebody comes forward with an actual "extend vfat to do exfat" patch,
>we should at that point have a discussion about relative merits....

This patch going into staging doesn't necessarily mean that one day
it'll get moved to fs/exfat/. It's very possible that the approach would
instead be to use the staging code for reference, build this
functionality in fs/fat/, and kill off the staging code when it's not
needed anymore.

With regards to missing specs/docs/whatever - our main concern with this
release was that we want full interoperability, which is why the spec
was made public as-is without modifications from what was used
internally. There's no "secret sauce" that Microsoft is hiding here.

How about we give this spec/code time to get soaked and reviewed for a
bit, and if folks still feel (in a month or so?) that there are missing
bits of information related to exfat, I'll be happy to go back and try
to get them out as well.

--
Thanks,
Sasha

