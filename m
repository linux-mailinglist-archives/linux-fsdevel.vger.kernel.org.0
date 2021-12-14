Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D7247481A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 17:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhLNQbf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 11:31:35 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:36178 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbhLNQbe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:References:Cc:To:From:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Z6zW5Qd6tfw+PKFZVRrNvKJyywIeqtC44M8EtfxF+44=; b=lKYiGTufYfVnndlG66V4Bdub3C
        Zjo421LWIhcLg2+9DxHPcvEXuMBcA5CLm67TCPcbyEmgf80iMIEmbz87Y1oleiXY2SbRk26T4VTAJ
        zyN+SYFYkDH1PlP/Bb5skD6nIfmIutnuuKkovgK0yiseshLTsxP5P0eBZL0PQyjLHIxi8WqiGpa2h
        HtFlGnz5Ou/f0gahFeDL5yBqhgdKwNreGF3frz89+ZyV3HTkq0a4gXbP6Jan+1x4URJNLG64rPMyu
        T5pv0cy92da6lb7F1B0ejKmoC/Q9zDy1uUJ+ZUaOKJdsk9KKwggTxL0t4J1QIlcCUtDRHAI7TNND7
        dmEDTC1Q==;
Received: from [177.103.99.151] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1mxAi0-0009ZL-D4; Tue, 14 Dec 2021 17:31:20 +0100
Subject: Re: [PATCH 0/3] Some improvements on panic_print
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, feng.tang@intel.com,
        siglesias@igalia.com, kernel@gpiccoli.net
References: <20211109202848.610874-1-gpiccoli@igalia.com>
 <4b710b02-b3a7-15ef-d1b9-c636352f41d1@igalia.com>
Message-ID: <eb19ac0c-b2b2-337a-6b7d-a3bff57d016d@igalia.com>
Date:   Tue, 14 Dec 2021 13:31:04 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <4b710b02-b3a7-15ef-d1b9-c636352f41d1@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26/11/2021 18:34, Guilherme G. Piccoli wrote:
> Hi everybody, is there any feedback for this series?
> Thanks in advance,
> 
> 
> Guilherme

Hey folks, this is a(nother) bi-weekly ping - if anybody has any
suggestions on how could we move forward with this series, that'd
greatly appreciated!

Thanks in advance,


Guilherme

