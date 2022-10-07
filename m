Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB88E5F7B84
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 18:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJGQdX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 12:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiJGQdV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:33:21 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B4810B785;
        Fri,  7 Oct 2022 09:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cvNDO/ExAXPGofkYjMl58NiIUWZzmPEeQSFlp7NMIRY=; b=VKhe9EcImLQM+pIBIAMtQG83DJ
        cgTQk26Cbt7Zo2g9N9vZklnMBdne8cUjE1nZYrsl2zXDG0bhFZGU/gfRTchSyvMyg0OYV8J+3jimz
        NeDMt+K1A1cjlZXfjVk8jhHvQkPoJKPqrydI5ixAef3jHjxK+3PSycYCxN2D3Pi73UbMocRQSRN1H
        jLJO2+CUgb7O8YP1Pg/Ou76wnapxxXl0otRW1lyU05bij6uNa0CVQruRxBtuNcNotWPLiIuuWOFkG
        pGJ7cgrq9eB7obEV/XdR1VwAePA+QiOZsqcIBV6PxaQu5Aggt6+A0xxFtecYLJ82McQQ8x1oiG+ff
        UVj0KBqg==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ogqHf-00DLP8-IT; Fri, 07 Oct 2022 18:33:12 +0200
Message-ID: <8e3b9e43-2dcf-76b1-b9bc-d66cb1e059cd@igalia.com>
Date:   Fri, 7 Oct 2022 13:32:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 6/8] MAINTAINERS: Add a mailing-list for the pstore
 infrastructure
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-7-gpiccoli@igalia.com>
 <202210061616.9C5054674A@keescook>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <202210061616.9C5054674A@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/10/2022 20:22, Kees Cook wrote:
> On Thu, Oct 06, 2022 at 07:42:10PM -0300, Guilherme G. Piccoli wrote:
>> Currently, this entry contains only the maintainers name. Add hereby
> 
> This likely need a general refresh, too.
> 
> Colin, you haven't sent anything pstore related since 2016. Please let
> me know if you'd like to stay listed here.
> 
> Anton, same question for you (last I see is 2015).
> 
> Tony, I see your recent responses, but if you'd rather not be bothered
> by pstore stuff any more, please let me know. :)
> 

Hi Kees, in case you want an extra pair of eyes to review/test pstore,
you can add me as reviewer - since we're using pstore in the Steam Deck
now and I have some improvements/fixes planned, I could help testing and
reviewing the stuff as well.

Feel free to ignore that as well if you think it's not pertinent!
Thanks,


Guilherme
