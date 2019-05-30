Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20EFD3025F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2019 20:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfE3SyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 May 2019 14:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfE3SyS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 May 2019 14:54:18 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C5F224B6B;
        Thu, 30 May 2019 18:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559242457;
        bh=q7K4pmGHUUBq3OOvKhZCDju5Yhxagmu1zFTfewcL3go=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dgpHrPpDfHfIKA83rjSp+ZqoKqKF9T0ncaTjYqKDrq0fEQLiRsrs1HHaz7osaMdge
         pqY3/OtH1zbLDA7nucMMijqsUXCYYBiapFM3Au60t/A0QrKOMGwxRssgOp+RDpcHFu
         wgDTyqudW+CCkNhybf2IbvoW0NMaCJVehv/Ek+Es=
Date:   Thu, 30 May 2019 11:54:15 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>, linux-api@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-integrity@vger.kernel.org, linux-ext4@vger.kernel.org,
        Victor Hsieh <victorhsieh@google.com>
Subject: Re: [PATCH v3 00/15] fs-verity: read-only file-based authenticity
 protection
Message-ID: <20190530185414.GD70051@gmail.com>
References: <20190523161811.6259-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523161811.6259-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 09:17:56AM -0700, Eric Biggers wrote:
> Hello,
> 
> This is a redesigned version of the fs-verity patchset, implementing
> Ted's suggestion to build the Merkle tree in the kernel
> (https://lore.kernel.org/linux-fsdevel/20190207031101.GA7387@mit.edu/).

Does anyone have any comments on this patchset?

- Eric
