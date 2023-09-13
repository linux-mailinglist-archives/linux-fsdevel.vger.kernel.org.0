Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF62679F0B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 19:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjIMR5Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 13:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjIMR5K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:57:10 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5050119AF;
        Wed, 13 Sep 2023 10:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oWoPVfSlu4gWS1kCZrzAd8phEhDP1tKA+QdcPHum+go=; b=VLe5S/h4vGsmlUIjI+/6AoXzEN
        YIHZQPhbG5iray+UFyHaqp22f6NXfUYk5seuhf9L0Bso+/vFPfKGqVAKPM41IUQa6RIzxiFePCsPw
        DG5EIcA1FaUDh2y6j6bFgcm/OfJAtEb/woiN/A3GgNlr4GOroqyDcZHT4DU5c7kfPHo7/Sj8xHJp0
        b9e2+s4x0Nj2hyvBY2crldnQSb120oqLiOnI7Tu6H3opJ5hSBfxK35y/iZeiFNZRmqRcDJ/AA5izL
        nrCsjJKS/E8+7v0lhLB23U9Z4OJ8ithBQ2I1u06KfMsYfR+u+nOM1133XfDC49pdsB223GYmytvGB
        OLn27LgQ==;
Received: from [187.116.122.196] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qgU6i-003Rj3-DH; Wed, 13 Sep 2023 19:56:56 +0200
Message-ID: <a8081396-2f6c-6b01-1953-beba5b67164a@igalia.com>
Date:   Wed, 13 Sep 2023 14:56:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V3 2/2] btrfs: Introduce the single-dev feature
Content-Language: en-US
To:     dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, david@fromorbit.com,
        kreijack@libero.it, johns@valvesoftware.com,
        ludovico.denittis@collabora.com, quwenruo.btrfs@gmx.com,
        wqu@suse.com, vivek@collabora.com
References: <20230831001544.3379273-1-gpiccoli@igalia.com>
 <20230831001544.3379273-3-gpiccoli@igalia.com>
 <20230911182804.GA20408@twin.jikos.cz>
 <b25f8b8b-8408-e563-e813-18ec58d3b5ca@oracle.com>
 <20230913172422.GW20408@twin.jikos.cz>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230913172422.GW20408@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/09/2023 14:24, David Sterba wrote:
> On Tue, Sep 12, 2023 at 05:20:42PM +0800, Anand Jain wrote:
>> [...]
> The mention patch has been folded to the scanning/register patch so you
> may now use misc-next as a base.
> 

Perfect, thanks David - I'm already working with misc-next here =)
