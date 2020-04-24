Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FC31B6E90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 08:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgDXG5H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 02:57:07 -0400
Received: from verein.lst.de ([213.95.11.211]:33448 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726078AbgDXG5H (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 02:57:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2E07068CEC; Fri, 24 Apr 2020 08:57:01 +0200 (CEST)
Date:   Fri, 24 Apr 2020 08:57:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        josh@joshtriplett.org, rishabhb@codeaurora.org, kubakici@wp.pl,
        maco@android.com, andy.gross@linaro.org, david.brown@linaro.org,
        bjorn.andersson@linaro.org, linux-wireless@vger.kernel.org,
        keescook@chromium.org, shuah@kernel.org, mfuzzey@parkeon.com,
        zohar@linux.vnet.ibm.com, dhowells@redhat.com,
        pali.rohar@gmail.com, tiwai@suse.de, arend.vanspriel@broadcom.com,
        zajec5@gmail.com, nbroeking@me.com, markivx@codeaurora.org,
        broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
        jewalt@lgsinnovations.com, cantabile.desu@gmail.com, ast@fb.com,
        andresx7@gmail.com, dan.rue@linaro.org, brendanhiggins@google.com,
        yzaikin@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] firmware_loader: re-export fw_fallback_config into
 firmware_loader's own namespace
Message-ID: <20200424065700.GB23906@lst.de>
References: <20200423203140.19510-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423203140.19510-1-mcgrof@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
