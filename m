Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C235F144BAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 07:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgAVGVw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 01:21:52 -0500
Received: from sonic301-20.consmr.mail.gq1.yahoo.com ([98.137.64.146]:40667
        "EHLO sonic301-20.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725871AbgAVGVw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 01:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1579674110; bh=NYqWPrMxo8wYOcTH+eM7Wpo1bSkUxGTDjvTnVvT0bNI=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=IOhYhPE6HE2ZWQIAQ7QnvQ9FIk9M59PMsvGEL93GTetmKqmAlTuEYHo7ii6ugWBY/HXGULfugapkl1kLXiNqyw9GR/h1AFsL2fh6BwkOOGZKDYUMtJ3+ZWTfLilxinUZ+YV6Zp/+/HESlvkVbIUloLyKOfuKVpxdjcO77sWqsPgQVrDigq01t+2dBadNyoZL9vRjjBEZusmIv4+hjQBtafaBGb5JqTFqjrOi4PW88sGD4syvUbjApSzAcLgXY43aCr0u0FsKU9TnvC+1SGjmMtO7tIgjCUrrrCcX8f9Tlf+OttDV9/AAqlldQAq9VfTCpn3cWFLWVZ4XsJZ6eosHcw==
X-YMail-OSG: ehCZpIoVM1kE2TMJZot03Zv9lec46zDS2J2iSc0SUyEk4FU9Fboajb87LClYF_4
 C_iHUj9aGnJLZTSvxUAYcy9dF072AxnCvybio3jBrhWhWB6z2J.cA7ApAWwGT6yaNbSdzg.iFXaY
 CI.Srt4s9xckO2npxte.B8WH7KObXjM6WWbr3VbLNukhUesFAgDFNIshv2tKoVYED3MauqP7UdcB
 6SogYTGfq_eci0uYP0I1iUxTrnTpkBDPmm5cvps6wwXEHChmaBCdxbkyytwjMbx1rKS74118CUxv
 BXpNG1P3HWhGh3qdobZP_.ft8PncxpdtmN3N7oFuuNvQj2HmjfjDNcFjUfYjcJPEwMZkV56IByFE
 sjjU7zyfUBvBIWvg5Ym9WtOqWW.gWxBSO9bDWddjN0Hjs7ZhCrCjZwUlaxkYPsViLoDw4WrcpKoR
 dO3JqzXoE12ZQjUOahyPySghxlzReF24UuspOzYeR9Mc24QMRJaHR_aj_bnNr9tq_MaeJUYsv_yk
 VcfDcslxtE_9Aoblk6UNqQFlnLmR7Wlgm0XfwwxReo.JH_JgR1.0eracClycihOMoxqmvxsnNI3e
 IfswTnYjczZUWi9M9_K.FnLbgvO2iDBd31TFpbU.vSU1vEkvEjemdIbtrxEQRECyxKDNzdXnNcjA
 vytBOrXGOLuVlDXp7TPXhDX1UDNDZK1_evHmR7mgP2AatHjxWfpf1d5zFglwhIvEhK8PTq8tq9fY
 m7rEH8XRvs8.WTu3.rjwpcNUm9HG.W8gkvvFYRIULEAZLuXflY2dIuM8mBv.9aL4553DBefJklpL
 UpEOAtF.N1fkr0sdsWYXa7wcNpq8wRplHcEUiGflpnD1jxQlGiVlqdd.wyFvwRy.8XCkIOvCNAh4
 VNSXrKj.T8XygcIjjos8rzgKVS4Ba789hoAkgFFUc1YDSu5pTKfpnXXblQFGD971H.VWpfuarP.s
 f4hsvLtcQodUud.68USmczUkOwTt7Qf1OE2gRk0G1Y65282T3HYIyrHv4btiVjVj1KRfO13N92rZ
 .zcABTLoxXpImuAuDaUitDiiP_go5fFWnyVhcyI1UOvnkA9Z7UL7M8Vvu9tU4VReC.CQtVmQDmuF
 nosWJ9tn1j1m92Sf0hyAjiZXnJK_cZb55LAbK2cgAtG1TUkSR3mXlPSREA5F9t1LtAFxG6mzOC4U
 .xm9kEwW3rLN8Uo6cUDq_5.8JYiDPoUlxySWsTnRuutvt2nYWRivla4183vGJTZubQB4h_GQhC6J
 _1wjzLTmLzeMvjqZFRbWQDlkCZ6PiYsdxTRKd_4P6nMkQwqZWTr4MwMXH5LTf8.NF_ZKfvjjqvy9
 sS9X5UCsYeLhqOKpqrAkMUbTtuITJjyAfvgyyJv5IzQPIEmcTR5rgii3XJAVdb6Y8NaHBwephLcl
 aBMNCqZrpRdqOZZAKdCBnjCpNhe1LkSXoKgZR1R0Rvw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Wed, 22 Jan 2020 06:21:50 +0000
Received: by smtp425.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0817606fc10322e20031da41fc46971e;
          Wed, 22 Jan 2020 06:21:47 +0000 (UTC)
Date:   Wed, 22 Jan 2020 14:21:36 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Generic page write protection
Message-ID: <20200122062122.GA10893@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20200122023222.75347-1-jglisse@redhat.com>
 <20200122042832.GA6542@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200122052118.GE76712@redhat.com>
 <20200122055219.GC6542@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200122060951.GA77704@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122060951.GA77704@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 21, 2020 at 10:09:51PM -0800, Jerome Glisse wrote:
> On Wed, Jan 22, 2020 at 01:52:26PM +0800, Gao Xiang wrote:
> > On Tue, Jan 21, 2020 at 09:21:18PM -0800, Jerome Glisse wrote:
> > 
> > <snip>
> > 
> > > 
> > > The block device code only need the mapping on io error and they are
> > > different strategy depending on individual fs. fs using buffer_head
> > > can easily be updated. For other they are different solution and they
> > > can be updated one at a time with tailor solution.
> > 
> > If I did't misunderstand, how about post-processing fs code without
> > some buffer_head but page->private used as another way rather than
> > a pointer? (Yes, some alternative ways exist such as hacking struct
> > bio_vec...)
> 
> The ultimate answer is that page write protection will not be allow
> for some filesystem (that's how the patchset is designed in fact so
> that things can be merge piecemeal). But they are many way to solve
> the io error reporting and that's one of the thing i would like to get
> input on.
> 
> > 
> > I wonder the final plan on this from the community, learn new rule
> > and adapt my code anyway.. But in my opinion, such reserve way
> > (page->mapping likewise) is helpful in many respects, I'm not sure
> > we could totally get around all cases without it elegantly...
> 
> I still need to go read what it is you are trying to achieve. But i
> do not see any reason to remove page->mapping

I could say it's a huge project :) and I mean there may be some other
options to "insert a pointer directly or indirectly to struct page. "

However, I agree the current page->mapping rule is complicated to be
sorted out in words and make full use it :)

Thanks,
Gao Xiang

