Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B58CAF1D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 10:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfD3IMi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 04:12:38 -0400
Received: from hr2.samba.org ([144.76.82.148]:31680 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfD3IMi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42627210; h=Date:Message-ID:From:Cc:To;
        bh=T88YzDCfdRRpRnlKh43Qlc+b4mJ+OnfqC7S9nbpXuZ4=; b=vRiWb9BVLTIgVJWYF6dRmg4j1O
        OuaXFf1xgG0vm7zCykhRGQq+Wnk3wqEGX3Z6jKjOkxlxf/slageYACYHNUztf2tPU0RN0nUx11etp
        xn/V34kkhZQYMz70PCshtVFwhHyfoTADViapzv2xUWTpOQG+MJ8NgxEbMSa289jy+b+E=;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1hLNsR-00080O-Bz; Tue, 30 Apr 2019 08:12:35 +0000
Subject: Re: Better interop for NFS/SMB file share mode/reservation
To:     Amir Goldstein <amir73il@gmail.com>,
        Pavel Shilovskiy <pshilov@microsoft.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Volker.Lendecke@sernet.de" <Volker.Lendecke@sernet.de>,
        Jeff Layton <jlayton@kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <CAOQ4uxjQdLrZXkpP30Pq_=Cckcb=mADrEwQUXmsG92r-gn2y5w@mail.gmail.com>
 <CAOQ4uxhuxoEsoBbvenJ8eLGstPc4AH-msrxDC-tBFRhvDxRSNg@mail.gmail.com>
 <20190426145006.GD25827@fieldses.org>
 <e69d149c80187b84833fec369ad8a51247871f26.camel@kernel.org>
 <CAOQ4uxjt+MkufaJWoqWSYZbejWa1nJEe8YYRroEBSb1jHjzkwQ@mail.gmail.com>
 <8504a05f2b0462986b3a323aec83a5b97aae0a03.camel@kernel.org>
 <CAOQ4uxi6fQdp_RQKHp-i6Q-m-G1+384_DafF3QzYcUq4guLd6w@mail.gmail.com>
 <1d5265510116ece75d6eb7af6314e6709e551c6e.camel@hammerspace.com>
 <CAOQ4uxjUBRt99efZMY8EV6SAH+9eyf6t82uQuKWHQ56yjpjqMw@mail.gmail.com>
 <95bc6ace0f46a1b1a38de9b536ce74faaa460182.camel@hammerspace.com>
 <CAOQ4uxhQOLZ_Hyrnvu56iERPZ7CwfKti2U+OgyaXjM9acCN2LQ@mail.gmail.com>
 <b4ee6b6f5544114c3974790a784c3e784e617ccf.camel@hammerspace.com>
 <bc2f04c55ba9290fc48d5f2b909262171ca6a19f.camel@kernel.org>
 <BYAPR21MB1303596634461C7D46B0A773B6390@BYAPR21MB1303.namprd21.prod.outlook.com>
 <CAOQ4uxirAW91yUe1nQUPPmarmMSxr_pco8NqKWB4srwyvgnRRA@mail.gmail.com>
From:   Uri Simchoni <uri@samba.org>
Openpgp: preference=signencrypt
Autocrypt: addr=uri@samba.org; prefer-encrypt=mutual; keydata=
 xsBNBFby8yABCAC5Yy67UKYFYlEH1qV/Wby+XhjMSYIwM7kAR7cyATzWzy+LHrYEV9HfcdbE
 8uIXsZJYHVrwzbK5GMV6Y+q4IEVYCkyQOTk+hDc10UqDHm6lvbKIeg7PlNtypA024bgGSzur
 BUenprtt3MxyBgreiPPa+UPbn5g+A2VC8Ud2wYv0x2IkMMCHa0tLkSDoQpuIFSP7q4YEvdn9
 E9dF6rtQYhTO3e9cQe8Faao4ujdaf8ymnIJXuVthubK1Ibg1rllnnlnCMT7/OVvaRACXSZeF
 9/7WTIswAQ0LooWY+Lhz4tLCYrxz5UclzphQAu/mDMZkIwfoyR2Btvnj35vpHgXyRl9HABEB
 AAHNHFVyaSBTaW1jaG9uaSA8dXJpQHNhbWJhLm9yZz7CwJUEEwECAD8CGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEEhnx9/eK+MtZ4dAL4Fx15pugHO7kFAlxOrQQFCQc87VoACgkQ
 Fx15pugHO7nX+wf/RenBK3LNFfLJ/pEk37p4SLWEJcfBjy5xGIQ4brwFAkvozfSh1qtVmz0g
 mmT/APAvwcpwRChxtUoK8O5208D7MzPCPUK8j7re/+U1y7dPSgtx17p8az72m6PKp9tTGjk1
 yDP1/wftJbhxCTu2ZARnMkbHliOi7eaaEsS3IMRS1Weuy5/7A64c93nV9GlRTu0ixmzqm2hj
 hyfjnSizx+TxIr1CODZLIxevgwomPmvgI2UGgx/L8o8ZFJrk4oV9vKTwf5a9zoPxoBysozuR
 XarEu8GecMkk92aYfLGZYREgVbWGxDQXGxHl1U65QPQWntGhn9MOR4ZzJxjesnX6OSCYMs7A
 TQRW8vMgAQgAqVFS+RiFSdQbXqZ9UryAGscHY+lgBV2Xb1af9F83MzppXVltQ9r7ajYyuUNJ
 G0O+4+xV50+4yMkKjFRspBg34syuUDWhQLWd6ypM75s1NKAv1ETY9WWKC3qn6CLhNXn3Sk1N
 JK2HvBub4TOXueFi3F9ePAx9+XFUPvbFhlJTzUHo8EqTRD64f6PQKafelzIPzFVRixHt5OfP
 Uv9au+98vFaV4Ne51ENxlQR2pjee/essHj4M5W7EcAcC3frjboUUvSqptYnayrVViuZ3dquU
 T9Nsm/D8lVj9Gk8RGu4+KXC8vkDULdXN4QRayagb2Yw0JhE9DH+XQy1oInH6FgdNJwARAQAB
 wsB8BBgBAgAmAhsMFiEEhnx9/eK+MtZ4dAL4Fx15pugHO7kFAlxOrS8FCQc87YEACgkQFx15
 pugHO7mkEAf/cr/X7vJwKgbMVVeY3zxfD1IEUoWqwm0PF0jop+yi9BMgn71OLiVJbiFtoTE3
 XF+TDcVsij36ahkSOKTF/OcO3wlHLmK2PrftfH07O+zq30qYWHsH6QkFN/vwZ9C7O0K56c1Z
 cvhd8ZB/u8iy3QzCxGgvjZl2XctUGgRVdyX2OyEupWMjuO6d/k5X91GXJyFZghOjjADGORZg
 WwPAVztL1sBp4ERaIWxEXrPxg8eQm7QH4sI2pwKRQxsRGY6U1dDzdkyLBqvC4Tks4s/pZjBC
 SIMU2TPqEyeztkZaVBSWHFNNCsBKIJ+35T5uJnhXjcgKeXlxjk7WbMHZWm8RaYFqIA==
Message-ID: <677e86ee-59b9-0826-481f-955074d164ed@samba.org>
Date:   Tue, 30 Apr 2019 11:12:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxirAW91yUe1nQUPPmarmMSxr_pco8NqKWB4srwyvgnRRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/30/19 3:31 AM, Amir Goldstein via samba-technical wrote:
>>
>> About O_DENYDELETE: I don't understand how we may reach a good interop story without a proper implementation of this flag. Windows apps may set it and Samba needs to respect it. If an NFS client removes such an opened file, what will Samba tell the Windows client?
>>
> 
> Samba will tell the Windows client:
> "Sorry, my administrator has decided to trade off interop with nfs on
> share modes,
> with DENY_DELETE functionality, so I cannot grant you DENY_DELETE that you
> requested."
> Not sure if that is workable. Samba developers need to chime in.
> 
> Thanks,
> Amir.
> 

On Windows you don't ask for DENY_DELETE, you get it by default unless
you ask to *allow* deletion. If you fopen() a file, even for
reading-only, the MSVC standard C library would open it with delete
denied because it does not explicitly request to allow it. My guess is
that runtimes of other high-level languages behave that way too on
Windows. That means pretty much everything would stop working.

Thanks,
Uri.
