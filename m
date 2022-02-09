Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFBC24AF4C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 16:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbiBIPGj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 10:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbiBIPGi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:06:38 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF153C06157B;
        Wed,  9 Feb 2022 07:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WZOcUHomPacejbhw1MKsv8v3w9dd0gwh3fSPRthDHH0=; b=VxhFUJ24lFKgv/7Xet2yYxcGSE
        hszcJPc0xzGK3/tSjP8Qi1sDpVg6tjBP3LNHr8T1DeuE7hYO8r19sYD7AxSddUW65VPmJqb4oNBWL
        gzX4+I007XySuILHaOUL1fbwS3sj+1ydNgVCf/XMxcarnQFkJgFZklrtagohn/s134XrRx7IGsuOC
        xBsQxCs1Ks1YLC18ZLEgFwkZxtUyI+SkOEYerbkP6DpX1wk0eRbD387i2BBO9YEvE+hcMJHdQEprg
        ctV5AL7HpJaif14tr3top/zYEvFn4ZaoYonBJtktn+yJkfe7ffKe6ZoSMD1PWhIoXafU4S7WnDpvd
        eKgB3feA==;
Received: from 201-27-34-10.dsl.telesp.net.br ([201.27.34.10] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nHoY0-0003cB-Ih; Wed, 09 Feb 2022 16:06:20 +0100
Message-ID: <c4f0c53e-cfe4-b693-6af2-df827bc94fa8@igalia.com>
Date:   Wed, 9 Feb 2022 12:06:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] panic: Allow printing extra panic information on
 kdump
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>, akpm@linux-foundation.org
Cc:     Petr Mladek <pmladek@suse.com>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        feng.tang@intel.com, siglesias@igalia.com, kernel@gpiccoli.net
References: <20211109202848.610874-1-gpiccoli@igalia.com>
 <20211109202848.610874-4-gpiccoli@igalia.com> <Yd/qmyz+qSuoUwbs@alley>
 <7c516696-be5b-c280-7f4e-554834f5e472@igalia.com>
 <c10fc4fc-58c9-0b3f-5f1e-6f44b0c190d2@igalia.com>
 <20220209083951.50060e15@canb.auug.org.au>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220209083951.50060e15@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/02/2022 18:39, Stephen Rothwell wrote:
> Hi Guilherme,
> [...] 
> Dropped from linux-next today.
> 

Hi Stephen, thanks! I'm still seeing this patch over there, though - I'm
not sure if takes a while to show up in the tree...

Notice this request is only for patch 3/3 in this series - patches 1 and
2 are fine, were reviewed and accepted =)

Cheers,


Guilherme
