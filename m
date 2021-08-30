Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60073FBB85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 20:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbhH3SLq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 14:11:46 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:59376 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238150AbhH3SLp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 14:11:45 -0400
Received: from optiplex.localdomain ([90.92.89.109])
        by mwinf5d59 with ME
        id nuAp250092MZPaq03uAp6j; Mon, 30 Aug 2021 20:10:50 +0200
X-ME-Helo: optiplex.localdomain
X-ME-Auth: amVhbi1waWVycmUuYW5kcmVAd2FuYWRvby5mcg==
X-ME-Date: Mon, 30 Aug 2021 20:10:50 +0200
X-ME-IP: 90.92.89.109
From:   =?UTF-8?Q?Jean-Pierre_Andr=c3=a9?= <jean-pierre.andre@wanadoo.fr>
Subject: Stable NTFS-3G + NTFSPROGS 2021.8.22 Released
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        ntfs-3g-devel <ntfs-3g-devel@lists.sourceforge.net>,
        ntfs-3g-news <ntfs-3g-news@lists.sourceforge.net>
Message-ID: <d343b1d7-6587-06a5-4b60-e4c59a585498@wanadoo.fr>
Date:   Mon, 30 Aug 2021 19:59:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greetings,

Main topics:

   - New stable release
   - Security advisory
   - Project moved to GitHub
   - Performance notes

The new stable release of NTFS-3G and ntfsprogs is available which 
includes important security fixes. The security advisory is available at

https://github.com/tuxera/ntfs-3g/security/advisories/GHSA-q759-8j5v-q5jp

The NTFS-3G project globally aims at providing a stable NTFS driver. The 
project's advanced branch has specifically aimed at developing, 
maturing, and releasing features for user feedback prior to feature 
integration into the project's main branch.

The parallel existence of both a stable and advanced variant maintained 
across several locations has caused some confusion. In particular, the 
Linux distributions observed different policies in selecting which 
version they use for their packaging. That led to users questioning the 
differences between features, and to additional challenges in providing 
support.

We've decided to merge the two projects and maintain a single repository 
for source code and documentation on GitHub. As the projects have always 
remained in close contact, this will cause no discontinuity in the 
released features, while enabling smoother support. The former 
repository on Sourceforge will be discontinued after a grace period, to 
allow users time to adapt to the project's new state. Please use 
GitHub's infrastructure for issue submission and release notification.

There have been some reports about very slow performance. Performance is 
a complex topic and NTFS-3G always aimed for stability, interoperability 
and portability over performance. Having said that, we did some 
investigation and benchmarking. What we have found are

1. Some distributions use an older and slower version of NTFS-3G.

2. The "big_writes" mount option is not used. This option can increase 
 >4kB IO block size write speed by 2-8 times. File transfers typically 
use 128kB which usually give a 3-4 times speed improvement. The option 
is safe to use and we plan to enable it by default in the next stable 
release.

3. Incorrect interpretation of benchmark results. For example in a 
recent public case the total runtime was completely distorted by an 
irrelevant test case hereby a wrong conclusion was made, namely NTFS-3G 
was thought to be over 4 times slower instead of 21% faster. More about 
this soon on linux-fsdevel.

In our file transfer benchmarks we have found NTFS-3G read and write 
speed was 15-20% less compared to ext4. Read was 3.4 GB/s versus 2.8 
GB/s, and write was 1.3 GB/s vs 1.1 GB/s. Nevertheless, different 
benchmarks can give different results.

The new release can be downloaded from

     https://github.com/tuxera/ntfs-3g/releases/tag/2021.8.22

Changelog is available at

     https://github.com/tuxera/ntfs-3g/wiki/NTFS-3G-Release-History

Many thanks to Rakesh Pandit, Jussi Hietanen, Erik Larsson, Szabolcs 
Szakacsits and many Tuxerians for their contributions to this release 
and to the migration to GitHub.

We also want to add special thanks to Jeremy Galindo, Akshay Ajayan, 
Kyle Zeng and Fish Wang, whose analyses were of great help in improving 
the security of the code.

With best regards,

Jean-Pierre & Tuxera Open Source Team
