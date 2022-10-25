Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8127C60D0DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 17:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiJYPki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 11:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbiJYPkh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:40:37 -0400
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Oct 2022 08:40:35 PDT
Received: from omta035.useast.a.cloudfilter.net (omta035.useast.a.cloudfilter.net [44.202.169.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86325D73C2
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 08:40:34 -0700 (PDT)
Received: from eig-obgw-5015a.ext.cloudfilter.net ([10.0.29.155])
        by cmsmtp with ESMTP
        id nLG2ojAcwVgqJnM19om4Ws; Tue, 25 Oct 2022 15:39:03 +0000
Received: from gator3309.hostgator.com ([192.254.250.173])
        by cmsmtp with ESMTP
        id nM17o8eRzmDtJnM18orxc2; Tue, 25 Oct 2022 15:39:02 +0000
X-Authority-Analysis: v=2.4 cv=Se/ky9du c=1 sm=1 tr=0 ts=63580316
 a=dOmPygiJvdb+5OUNGItVWg==:117 a=qTiTxQo9C7rYIChow7JK8A==:17
 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=Qawa6l4ZSaYA:10
 a=1agXfLV7zN0A:10 a=0NJJaq8bbSYA:10 a=z0P91oI6AAAA:8 a=cE2mi4AkTJCXTl7awD0A:9
 a=QEXdDO2ut3YA:10 a=4NrjmgzB0PWfekH-HHpv:22
Received: from [68.237.95.207] (port=55232 helo=[192.168.1.133])
        by gator3309.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <trapexit@spawn.link>)
        id 1onM17-004JGT-2t;
        Tue, 25 Oct 2022 10:39:01 -0500
Message-ID: <7d293f21-c0b4-46eb-6822-4015560f787e@spawn.link>
Date:   Tue, 25 Oct 2022 11:38:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Should FUSE set IO_FLUSHER for the userspace process?
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>
References: <87mtaxt05z.fsf@vostro.rath.org>
 <CAJfpegv=1UjycheWyANxsoOM5oCf7DGs9OKNzhNw_dSETBDCVQ@mail.gmail.com>
Content-Language: en-US
From:   Antonio SJ Musumeci <trapexit@spawn.link>
In-Reply-To: <CAJfpegv=1UjycheWyANxsoOM5oCf7DGs9OKNzhNw_dSETBDCVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator3309.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spawn.link
X-BWhitelist: no
X-Source-IP: 68.237.95.207
X-Source-L: No
X-Exim-ID: 1onM17-004JGT-2t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.133]) [68.237.95.207]:55232
X-Source-Auth: trapexit@spawn.link
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: YmlsZTtiaWxlO2dhdG9yMzMwOS5ob3N0Z2F0b3IuY29t
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfETqrnfSpSTMvOaWAwvIBVWfzhm9rPmr7FDi5jTKZ7eQQ9G0zIOd7kVjjm+vaqFCo1Cd1GnPYPXkfEjCFdXxcdVEJwT7Oq/zxa9Iydh8R9sZV89gx82z
 3o2XofFEOCxKtBUwFwljRK5OUjXBjf/H45Czz7oof42hMMBfS67KNH6refd1o50xrYUNd/0SrTmWgrRyRWaWiOeOH6dWvh74KmLYSC/b7UEVRehSrX+dmC8g
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/19/22 05:20, Miklos Szeredi wrote:
> On Sun, 18 Sept 2022 at 13:03, Nikolaus Rath <Nikolaus@rath.org> wrote:
>> Hi,
>>
>> Should the FUSE kernel driver perhaps set PR_SET_IO_FLUSHER for the FUSE
>> userspace process daemon when a connection is opened?
>>
>> If I understand correctly, this is necessary to avoid a deadlocks if the
>> kernel needs to reclaim memory that has to be written back through FUSE.
> The fuse kernel driver is careful to avoid such deadlocks.  When
> memory reclaim happens, it copies data to temporary buffers and
> immediately finishes the reclaim from the memory management
> subsystem's point of view.   The temp buffers are then sent to
> userspace and written back without having to worry about deadlocks.
> There are lots of details missing from the above description, but this
> is the essence of the writeback deadlock avoidance.
>
> Thanks,
> Miklos

Miklos, does this mean that FUSE servers shouldn't bother setting 
PR_SET_IO_FLUSHER? Are there any benefits to setting it explicitly or 
detriments to not setting it?

