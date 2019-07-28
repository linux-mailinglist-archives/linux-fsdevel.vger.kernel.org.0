Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB78977C8E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2019 02:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfG1AqF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jul 2019 20:46:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfG1AqF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jul 2019 20:46:05 -0400
Received: from [192.168.0.101] (unknown [180.111.32.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B06A2086D;
        Sun, 28 Jul 2019 00:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564274764;
        bh=hsA8mSmdQowOsHRk9e/OVmaiCpd4e8KUxVDsMnzqcmM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=0fpJx0lhiOeLOAsoah0WBkaoCDA5/zd4qGBunNewqDCve1P+H+ZTiVjUYEvSWi7cH
         yqgyGp7/yrBQRuCVvN4YaEo5hPe1u371k1oVeh2rjQ3GDT0ha6jB6hQiRNQGPU8uIM
         D8oZofcCILnWY2Zn/Wcu55XjaUbnLnVPK8JyMp8w=
Subject: Re: [f2fs-dev] [PATCH v4 2/3] f2fs: include charset encoding
 information in the superblock
To:     Daniel Rosenberg <drosen@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-doc@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com
References: <20190723230529.251659-1-drosen@google.com>
 <20190723230529.251659-3-drosen@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <af60ce55-1a29-d8da-81e4-77c880f4a0d0@kernel.org>
Date:   Sun, 28 Jul 2019 08:45:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190723230529.251659-3-drosen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-7-24 7:05, Daniel Rosenberg via Linux-f2fs-devel wrote:
> Add charset encoding to f2fs to support casefolding. It is modeled after
> the same feature introduced in commit c83ad55eaa91 ("ext4: include charset
> encoding information in the superblock")
> 
> Currently this is not compatible with encryption, similar to the current
> ext4 imlpementation. This will change in the future.
> 
> From the ext4 patch:
> """
> The s_encoding field stores a magic number indicating the encoding
> format and version used globally by file and directory names in the
> filesystem.  The s_encoding_flags defines policies for using the charset
> encoding, like how to handle invalid sequences.  The magic number is
> mapped to the exact charset table, but the mapping is specific to ext4.
> Since we don't have any commitment to support old encodings, the only
> encoding I am supporting right now is utf8-12.1.0.
> 
> The current implementation prevents the user from enabling encoding and
> per-directory encryption on the same filesystem at the same time.  The
> incompatibility between these features lies in how we do efficient
> directory searches when we cannot be sure the encryption of the user
> provided fname will match the actual hash stored in the disk without
> decrypting every directory entry, because of normalization cases.  My
> quickest solution is to simply block the concurrent use of these
> features for now, and enable it later, once we have a better solution.
> """
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
