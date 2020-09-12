Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E557267C68
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Sep 2020 22:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgILU74 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Sep 2020 16:59:56 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:57722 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbgILU7z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Sep 2020 16:59:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 79E8A8EE0E2;
        Sat, 12 Sep 2020 13:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1599944393;
        bh=7hEQKjI9O8nacR0TWKtYnXQr5cvLv5P4viB2BZaAnck=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Xaqe/rNqGsZqGTYX7F7OsxrQprW1LzXd9FJTjf/UcehK1yt9jLTqhef+GliZhR8Fr
         aY4xZ1S10JW6/XWKoklAfSd3JN1USn47F4uuRiGIOWZdUvovqt6ZvjpYb81FkJYruE
         l9m+fhEVU4HL7CFu0JUjRyBBZltXPubDNgtxLcgM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gxACGVMy-c8L; Sat, 12 Sep 2020 13:59:53 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 87CFF8EE07B;
        Sat, 12 Sep 2020 13:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1599944393;
        bh=7hEQKjI9O8nacR0TWKtYnXQr5cvLv5P4viB2BZaAnck=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Xaqe/rNqGsZqGTYX7F7OsxrQprW1LzXd9FJTjf/UcehK1yt9jLTqhef+GliZhR8Fr
         aY4xZ1S10JW6/XWKoklAfSd3JN1USn47F4uuRiGIOWZdUvovqt6ZvjpYb81FkJYruE
         l9m+fhEVU4HL7CFu0JUjRyBBZltXPubDNgtxLcgM=
Message-ID: <1599944388.6060.25.camel@HansenPartnership.com>
Subject: Re: Kernel Benchmarking
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Hugh Dickins <hughd@google.com>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Sat, 12 Sep 2020 13:59:48 -0700
In-Reply-To: <CAHk-=whjhYa3ig0U_mtpoU5Zok_2Y5zTCw8f-THkf1vHRBDNuA@mail.gmail.com>
References: <CAHk-=wiZnE409WkTOG6fbF_eV1LgrHBvMtyKkpTqM9zT5hpf9A@mail.gmail.com>
         <aa90f272-1186-f9e1-8fdb-eefd332fdae8@MichaelLarabel.com>
         <CAHk-=wh_31_XBNHbdF7EUJceLpEpwRxVF+_1TONzyBUym6Pw4w@mail.gmail.com>
         <e24ef34d-7b1d-dd99-082d-28ca285a79ff@MichaelLarabel.com>
         <CAHk-=wgEE4GuNjcRaaAvaS97tW+239-+tjcPjTq2FGhEuM8HYg@mail.gmail.com>
         <6e1d8740-2594-c58b-ff02-a04df453d53c@MichaelLarabel.com>
         <CAHk-=wgJ3-cEkU-5zXFPvRCHKkCCuKxVauYWGphjePEhJJgtgQ@mail.gmail.com>
         <d2023f4c-ef14-b877-b5bb-e4f8af332abc@MichaelLarabel.com>
         <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
         <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
         <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com>
         <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
         <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
         <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
         <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
         <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
         <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
         <CAHk-=whjhYa3ig0U_mtpoU5Zok_2Y5zTCw8f-THkf1vHRBDNuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2020-09-12 at 10:59 -0700, Linus Torvalds wrote:
[...]
> Any other suggestions than those (a)-(d) ones above?

What about revert and try to fix the outliers?  Say by having a timer
set when a process gets put to sleep waiting on the page lock.  If the
time fires it gets woken up and put at the head of the queue.  I
suppose it would also be useful to know if this had happened, so if the
timer has to be reset because the process again fails to win and gets
put to sleep it should perhaps be woken after a shorter interval or
perhaps it should spin before sleeping.

I'm not advocating this as the long term solution, but it could be the
stopgap while people work on (c).

James

