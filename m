Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41448266889
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 21:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgIKTIb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 15:08:31 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.196]:19422 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725786AbgIKTIb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 15:08:31 -0400
X-Greylist: delayed 1337 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Sep 2020 15:08:30 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 875EE154BC
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2020 13:46:08 -0500 (CDT)
Received: from gator3309.hostgator.com ([192.254.250.173])
        by cmsmtp with SMTP
        id Go3jkbKcyBD8bGo3kkso0b; Fri, 11 Sep 2020 13:46:08 -0500
X-Authority-Reason: nr=8
Received: from pool-68-160-221-54.nycmny.fios.verizon.net ([68.160.221.54]:51155 helo=[192.168.1.133])
        by gator3309.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <trapexit@spawn.link>)
        id 1kGo3i-0008LX-KI; Fri, 11 Sep 2020 13:46:06 -0500
Subject: Re: [fuse-devel] [PATCH V8 0/3] fuse: Add support for passthrough
 read/write
To:     Alessio Balsini <balsini@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        David Anderson <dvander@google.com>,
        Eric Yan <eric.yan@oneplus.com>, Jann Horn <jannh@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200911163403.79505-1-balsini@android.com>
From:   Antonio SJ Musumeci <trapexit@spawn.link>
Message-ID: <21e1b3be-6cc1-c73a-4e3e-963e2dd64f1f@spawn.link>
Date:   Fri, 11 Sep 2020 14:46:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911163403.79505-1-balsini@android.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator3309.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spawn.link
X-BWhitelist: no
X-Source-IP: 68.160.221.54
X-Source-L: No
X-Exim-ID: 1kGo3i-0008LX-KI
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-68-160-221-54.nycmny.fios.verizon.net ([192.168.1.133]) [68.160.221.54]:51155
X-Source-Auth: trapexit@spawn.link
X-Email-Count: 17
X-Source-Cap: YmlsZTtiaWxlO2dhdG9yMzMwOS5ob3N0Z2F0b3IuY29t
X-Local-Domain: yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/11/2020 12:34 PM, Alessio Balsini via fuse-devel wrote:
> Add support for file system passthrough read/write of files when enabled in
> userspace through the option FUSE_PASSTHROUGH.
Might be more effort than it is worth but any thoughts on userland error 
handling for passthrough? My use case, optionally, responds to read or 
write errors in particular ways. It's not an unreasonable tradeoff to 
disable passthrough if the user wants those features but was wondering 
if there was any consideration of extending the protocol to pass 
read/write errors back to the fuse server.
