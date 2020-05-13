Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8354D1D1C48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 19:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389885AbgEMRa3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 13:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732731AbgEMRa2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 13:30:28 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98B3E2053B;
        Wed, 13 May 2020 17:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589391028;
        bh=DUxmL2DW8AGAbEDV0E3S6D4sSXQdPvCUpnXQhcWR/Ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uwum2c3QVIrZZTK8102bH9IE8j/ppIJPr2jA9iSaVCnTI6vRkvuPK9CWKzh9OSW+Q
         Ja2aYpKfBVoClFrP15T4+vEHspb8GhNnlHfFc/vYHCvXEiydgTWIMXyI/Y6q/kX4zP
         6Z93+gkKt1WwCVYlW1zTdXo49pvlmgsdvZKt7itM=
Date:   Wed, 13 May 2020 10:30:26 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v12 04/12] block: Make blk-integrity preclude hardware
 inline encryption
Message-ID: <20200513173026.GD1243@sol.localdomain>
References: <20200430115959.238073-1-satyat@google.com>
 <20200430115959.238073-5-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430115959.238073-5-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 30, 2020 at 11:59:51AM +0000, Satya Tangirala wrote:
> Whenever a device supports blk-integrity, make the kernel pretend that
> the device doesn't support inline encryption (essentially by setting the
> keyslot manager in the request queue to NULL).
> 
> There's no hardware currently that supports both integrity and inline
> encryption. However, it seems possible that there will be such hardware
> in the near future (like the NVMe key per I/O support that might support
> both inline encryption and PI).
> 
> But properly integrating both features is not trivial, and without
> real hardware that implements both, it is difficult to tell if it will
> be done correctly by the majority of hardware that support both.
> So it seems best not to support both features together right now, and
> to decide what to do at probe time.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>

Looks good, you can add:

    Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
