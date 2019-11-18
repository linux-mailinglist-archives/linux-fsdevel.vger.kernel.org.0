Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD59C100749
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2019 15:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKROXn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Nov 2019 09:23:43 -0500
Received: from mail3.bemta25.messagelabs.com ([195.245.230.84]:58924 "EHLO
        mail3.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726627AbfKROXm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ts.fujitsu.com;
        s=200619tsfj; t=1574087020; i=@ts.fujitsu.com;
        bh=v4ugclb7Ac9tF4IOrOt6IMKMq2976QiWVp1FMkr4oPI=;
        h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Transfer-Encoding:Content-Type;
        b=KqJM0YdQy+mI0UAmdkgt4Cw2trosriqAuKEZOGbSaMu44rlE+BC5Yz/gjHYpF8vch
         7CEhTtic98gkoUa1ro0adIJ5BQ4QmlJ953OOzaHsq1fSFbd0kS8NOUHTu86pU3gbAC
         OHYp4zCZTg9N295BPktdkEnpC/ITWdaKA5vSGjOJW47V+ekj8NcQDXSlrTptc5Fm9W
         UY8BsDNdy8XGywBj2hSampgVA16kW8+UccawKXdR7w9UyFGO+feT/ijO+Rvz5xi5tl
         4MfgH965CharW3UUDSbXX9v95Y3DqlJalBTgnEzz58vsuFVIW8cIcaJlwLrC33IOFn
         ABmD6OHX/edyg==
Received: from [46.226.52.197] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-west-1.aws.symcld.net id 7C/A5-03226-B69A2DD5; Mon, 18 Nov 2019 14:23:39 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRWlGSWpSXmKPExsViZ8MxVTd75aV
  Yg2uzNC2+/Wlls9iz9ySLxeVdc9gszv89zurA4rFz1l12j8+b5Dw2PXnLFMAcxZqZl5RfkcCa
  8XPvGsaCJ4IVR4/9ZWlgPMrTxcjFISQwh1Fi/6ZpTBDOAkaJ7r+djF2MnBxsAgYSu14dYgaxR
  QRUJXbcncgKYjMLxEpcmrQBrEZYwFni4ouNYDYLUM3O50dYQGxeAUOJvR19QEM5ODgFLCTezA
  drFQJqffd7MiNEiaDEyZlPWCBGykt0XG6EGq8jsWD3J7YJjLyzkJTNQlI2C0nZAkbmVYwWSUW
  Z6RkluYmZObqGBga6hoZGuoaW5kBsppdYpZukl1qqW55aXKJrqJdYXqxXXJmbnJOil5dasokR
  GKYpBUeP7GB89/Wt3iFGSQ4mJVFeefuLsUJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkeMNWXIoVE
  ixKTU+tSMvMAcYMTFqCg0dJhFdgOVCat7ggMbc4Mx0idYpRl+P6+71LmYVY8vLzUqXEeaeBFA
  mAFGWU5sGNgMXvJUZZKWFeRgYGBiGegtSi3MwSVPlXjOIcjErCvFYgU3gy80rgNr0COoIJ6Aj
  tHedAjihJREhJNTDJrUrdsFTegP/ZXO7wv703N39vb4ietDRPJU47u1Yzw6JWdfPZqBvz8rkv
  L59zcvf9lENP5fg0HnzhdKict/6Iq+DMwLa0DdOat4eF2Roaund/Dj9wb9ok2z7dr/OvSv3kP
  DTn1tJ7n6Letufseda6tu+Nq9QT1jvbUpMXb1LRnp4RxrVTcIHrG6/sewLGB6JZnmyeHvNvKQ
  ufyOQym4KZW++Xz3b7m/e/LcZw2+b4bz0yDGK7W47F8r98Wuw6qWpmS2I617mPIjei0s5+UFn
  35OeE7P/PA/7kWIhFzJkdw+lr8Lw7Ircp/YzGqvy/17ZncZ2fdun3IQ7+UqXjc92enl34QO+b
  yvacvD2vT7IxKbEUZyQaajEXFScCAKGqYH9aAwAA
X-Env-Sender: dietmar.hahn@ts.fujitsu.com
X-Msg-Ref: server-7.tower-285.messagelabs.com!1574087019!272990!1
X-Originating-IP: [62.60.8.149]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.22; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5619 invoked from network); 18 Nov 2019 14:23:39 -0000
Received: from unknown (HELO mailhost2.uk.fujitsu.com) (62.60.8.149)
  by server-7.tower-285.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 18 Nov 2019 14:23:39 -0000
Received: from sanpedro.mch.fsc.net ([172.17.20.6])
        by mailhost2.uk.fujitsu.com (8.14.5/8.14.5) with SMTP id xAIENVO9001237;
        Mon, 18 Nov 2019 14:23:31 GMT
Received: from amur.mch.fsc.net (unknown [10.172.102.131])
        by sanpedro.mch.fsc.net (Postfix) with ESMTP id 460259D00892;
        Mon, 18 Nov 2019 15:23:26 +0100 (CET)
From:   Dietmar Hahn <dietmar.hahn@ts.fujitsu.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dieti.hahn@gmail.com
Subject: Re: Kernel panic because of wrong contents in core_pattern
Date:   Mon, 18 Nov 2019 15:23:26 +0100
Message-ID: <2513527.0IqIISzq9R@amur.mch.fsc.net>
In-Reply-To: <20191115132740.GP26530@ZenIV.linux.org.uk>
References: <1856804.EHpamdVGlA@amur.mch.fsc.net> <20191115132740.GP26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Freitag, 15. November 2019, 14:27:40 CET schrieb Al Viro:
> On Fri, Nov 15, 2019 at 02:01:55PM +0100, Dietmar Hahn wrote:
> 
> > Later a user tool dumped with SIGSEGV and the linux system crashed.
> > I investigated the crash dump and found the cause.
> > 
> > Via format_corename() in fs/coredump.c the helper_argv[] with 3 entries is
> > created and helper_argv[0] == "" (because of the ' ' after the '|')
> > ispipe is set to 1.
> > Later in call_usermodehelper_setup():
> >   sub_info->path = path;  == helper_argv[0] == ""
> > This leads in call_usermodehelper_exec() to:
> >   if (strlen(sub_info->path) == 0)
> >                 goto out;
> > with a return value of 0.
> > But no pipe is created and thus cprm.file == NULL.
> > This leads in file_start_write() to the panic because of dereferencing
> >  file_inode(file)->i_mode)
> > 
> > I'am not sure what's the best way to fix this so I've no patch.
> > Thanks.
> 
> Check in the caller of format_corename() for **argv being '\0' and fail
> if it is?  I mean, turn that
>                 if (ispipe < 0) {
>                         printk(KERN_WARNING "format_corename failed\n");
>                         printk(KERN_WARNING "Aborting core\n");
>                         goto fail_unlock;
>                 }   
> in there into
> 		if (ispipe < 0 || !**argv) {
>                         printk(KERN_WARNING "format_corename failed\n");
>                         printk(KERN_WARNING "Aborting core\n");
>                         goto fail_unlock;
>                 }

Unfortunately this doesn't work because argv[0] is always 0 in case of ispipe
in format_corename():
	if (ispipe) {
		int argvs = sizeof(core_pattern) / 2;
		(*argv) = kmalloc_array(argvs, sizeof(**argv), GFP_KERNEL);
		if (!(*argv))
			return -ENOMEM;
		(*argv)[(*argc)++] = 0;
		++pat_ptr;
	}

The manpage says: The program must be ..., and must immediately
follow the '|' character.
Why not check this in format_corename(), maybe:

@@ -211,6 +211,8 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
                        return -ENOMEM;
                (*argv)[(*argc)++] = 0;
                ++pat_ptr;
+               if (isspace(*pat_ptr))
+                       return -EINVAL;
        }

Dietmar.





