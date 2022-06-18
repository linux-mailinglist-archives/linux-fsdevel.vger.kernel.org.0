Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D165503B3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 11:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiFRJP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 05:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiFRJP2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 05:15:28 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F8B22BD2;
        Sat, 18 Jun 2022 02:15:27 -0700 (PDT)
Date:   Sat, 18 Jun 2022 17:15:19 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655543725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ltJh13Z9ypXCSCvyXlx0k1B84eqnXYnTpXmZ+PP8pt0=;
        b=o2Qu2P0P+TRVKzi3DscQT7W8P3/mSmgh+xtBqQAGMbsoRu1lxLHMba2jj96GbvG3NmsgvP
        fxoXBpBfdvGaFzuGytmxAeuR6O8DcX07GDUGusZTET7ASuGT254EqcJefCFrLqVTVW2KJ9
        dmDOGBpMlH4CZQKfbqd3YdLOTLAHSbI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Fanjun Kong <fanjun.kong@linux.dev>
To:     songmuchun@bytedance.com, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com
Cc:     bh1scw@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/sysctl.c: Clean up indentation, replace spaces
 with tab.
Message-ID: <20220618091519.bfjbm4ifxpbx7yep@kong-Standard-PC-i440FX-PIIX-1996>
References: <20220522052933.829296-1-bh1scw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220522052933.829296-1-bh1scw@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi maintainer,

Could you help to review this patch? 

Thanks so much.

On 22 May 22 ◦ 13:29, bh1scw@gmail.com wrote:
> From: Fanjun Kong <bh1scw@gmail.com>
> 
> This patch fixes two coding style issues:
> 1. Clean up indentation, replace spaces with tab
> 2. Add space after ','
> 
> Signed-off-by: Fanjun Kong <bh1scw@gmail.com>
> ---
>  kernel/sysctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index e52b6e372c60..de8da34e02a5 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1277,8 +1277,8 @@ int proc_dointvec_jiffies(struct ctl_table *table, int write,
>  int proc_dointvec_userhz_jiffies(struct ctl_table *table, int write,
>  				 void *buffer, size_t *lenp, loff_t *ppos)
>  {
> -    return do_proc_dointvec(table,write,buffer,lenp,ppos,
> -		    	    do_proc_dointvec_userhz_jiffies_conv,NULL);
> +	return do_proc_dointvec(table, write, buffer, lenp, ppos,
> +				do_proc_dointvec_userhz_jiffies_conv, NULL);
>  }
>  
>  /**
> -- 
> 2.36.0
> 
