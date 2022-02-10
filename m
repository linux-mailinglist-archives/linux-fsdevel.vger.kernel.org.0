Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6363F4B0DD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 13:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241793AbiBJMvN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 07:51:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241791AbiBJMvM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:51:12 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C41264D;
        Thu, 10 Feb 2022 04:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yuPcI0QzBL48BxbAjyu4LlEm62NrnIzpXRoG3bjaCaI=; b=Dw6ucic43KkRADr2FWktACPMlR
        FLGDDzcs39F0aJ96aAm4RpX0fgVOXLXQtOM28jKeDcyt50+FLIZuW1biwtVAM4C86RTC05pcVu+Rq
        3aV5SfPtOHGOSdL7/i56HrMMk5HepSbPtsFzxy2gTHwzxX0T/+MogbXUxWgvOahj1qPZFZK47CVU2
        fr3K+M4hCbNDpBuq5CKvDdMGo8rZQJ3N4VssbvJ4Su480da2Iph3IjHXIiab9dZcGtAjMIU1IiXju
        IsnmDS3AMV6+YdoBedBjPoI8OetpGEUviQS/LrFe2sQoGyl58xKdHOGYmqKs0ryolGkJsrVfIPXWo
        KkpaT/sw==;
Received: from 201-27-34-10.dsl.telesp.net.br ([201.27.34.10] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nI8uU-0000mt-Qs; Thu, 10 Feb 2022 13:50:55 +0100
Message-ID: <b82f13ea-fc7e-7037-9f3f-5b3cc1d69257@igalia.com>
Date:   Thu, 10 Feb 2022 09:50:37 -0300
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
 <c4f0c53e-cfe4-b693-6af2-df827bc94fa8@igalia.com>
 <20220210102621.250d6741@canb.auug.org.au>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220210102621.250d6741@canb.auug.org.au>
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

On 09/02/2022 20:26, Stephen Rothwell wrote:
> [...]
>> Hi Stephen, thanks! I'm still seeing this patch over there, though - I'm
>> not sure if takes a while to show up in the tree...
> 
> Andrew did another mmotm release which put it back in.  I have removed
> it again for today.
> 
>> Notice this request is only for patch 3/3 in this series - patches 1 and
>> 2 are fine, were reviewed and accepted =)
> 
> Understood.
> 

Thanks a bunch! So it seems Andrew needs to remove patch 3 from mmotm right?

Cheers,


Guilherme
