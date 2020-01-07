Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99F56131DF2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 04:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgAGD1C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 22:27:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:41070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbgAGD1C (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 22:27:02 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 635782064C;
        Tue,  7 Jan 2020 03:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578367621;
        bh=X+2gVisxUGO+ou5FYDrr9uZg4m9jUcNFLB6+Fer2aIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LfEW/4iZ8qnK1J5++lGjKJbiPZaOc1+mcQo0dJvAKKH1jqBgvCGa1FGuHumf9Tq/n
         BzActTBfhUAou1qmgU78E2kBcxTbKq38S7CuCM6CLeBFkOwoGPX4Yd0kqEasQgDd+8
         U2qAOBKtGl2nsmSISRbhuKhVbYCKGr4Hf8IPj9nQ=
Date:   Mon, 6 Jan 2020 19:26:59 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v2 0/3] Fscrypt support for casefolded encryption
Message-ID: <20200107032659.GB705@sol.localdomain>
References: <20200107023323.38394-1-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107023323.38394-1-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 06, 2020 at 06:33:20PM -0800, Daniel Rosenberg wrote:
> These patches are to prepare fscrypt to support casefolding and
> encryption at the same time. Other patches will add those to the
> vfs, ext4 and f2fs. These patches are against fscrypt/master
> 
> Daniel Rosenberg (3):
>   fscrypt: Add siphash and hash key for policy v2
>   fscrypt: Don't allow v1 policies with casefolding
>   fscrypt: Change format of no-key token
> 

I think you should send out the full series again so that people have the needed
context when reviewing it.  It can still be on top of fscrypt.git#master if
that's easiest.  We can consider taking these three patches for 5.6 before the
fs/ext4/ and fs/f2fs/ parts in order to help avoid merge conflicts between git
trees, but that doesn't mean you can't send out the full series.

- Eric
