Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73716187AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 19:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiKCSii (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 14:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKCSig (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:38:36 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7EA100;
        Thu,  3 Nov 2022 11:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=usdmuKgaw6HvzvZzrbDExUhrQ+AzRsmA0SxS+bw7TRg=; b=i8oWZ4jiHrfGDlWuxM9FXtsIx+
        qex8oBVYNKtqgYHSKx9/CKulKavnkdFrAFa24PdrsIhYh4xaD3LR8WHQ8gxp5S0mNasIZMpNohVH0
        u/l0r98E4vxszXYbKXgU/8ghlOsJtRThyZXmyCcGtqcxES1PpBcNrtBPr602XEsmhzQHHtY015rp3
        oA8BPWJElXcJEl+FYxh++dMhzBgrs1eU4Gi/LOLSczQzQ1VEZzROMFGH8WkoR1UA578nCo6iWthQl
        3N0vtkzhQPUftgZS0tseM4wfLqKXBYT1KVekQNJRbrjSJpk+OquMNrQUsbugY4Y1Nh+9TSWyj9sjd
        vehFk/eA==;
Received: from [177.102.148.33] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oqf6i-00BsMN-Q9; Thu, 03 Nov 2022 19:38:29 +0100
Message-ID: <aac42f75-413b-c247-1a35-5d140ef38ff8@igalia.com>
Date:   Thu, 3 Nov 2022 15:38:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V3] efi: pstore: Add module parameter for setting the
 record size
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com
References: <20221101184808.80747-1-gpiccoli@igalia.com>
 <CAMj1kXH5B0Op7Aab45x_tdkM1YsoSJ9euNqLMzeJg4uK++ojJQ@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAMj1kXH5B0Op7Aab45x_tdkM1YsoSJ9euNqLMzeJg4uK++ojJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/11/2022 14:04, Ard Biesheuvel wrote:
> [...]
> Thanks, I'll queue this up for v6.2

Thanks a lot for all the discussions Ard, it was very informative =)
