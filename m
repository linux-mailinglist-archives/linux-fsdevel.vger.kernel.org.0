Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63BD41A497
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 23:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfEJVdy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 17:33:54 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45009 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbfEJVdt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 17:33:49 -0400
Received: by mail-ed1-f67.google.com with SMTP id b8so6945097edm.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2019 14:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mYLCrqAh6dGMRupORMTuLJWrL5feZF1QxoQSH4aJpzU=;
        b=SmumuDGrcJ5bVetydA2yfkeXDt1Z2G2LIlYxvLnjke6Wg5kUBXXcNJrpUGHKusgmwE
         kFJeBCfAGNRdUrFuqBTXEz4Ic5yc9HumCODEOzIUVLM4wpz1jB1Qwry3NgHtT0GfNvY8
         hEELCbKgDlvLYvEnqJ7xfVDAacA4LStaGKQM3aCuez7I5adnI+YUK8qcHaLvi0kAdNJW
         xAt4ic4PdsVnHHeYJJNUakl4IqWCjXsE3Mq5+g8aGQvZztKIPnLVa76Yhq6+57WwkaHb
         r1ae7KbUmNyL0TkwxvZt46pVoXozcsc9QjHT1zGLG4Krw03zOYUplHe2CN0iYuT8y7N0
         r1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mYLCrqAh6dGMRupORMTuLJWrL5feZF1QxoQSH4aJpzU=;
        b=RFAUS6lscbnPh+6K0Au8FoTZYqpSIRurou4c7ZPRAyPszEgU/kCiZUu9p2T8WQCXfC
         Vh5DnS2jOsfgixf9aXtwm919NzlsjRSGdpK+R2jB73TKfUyQe3iaPaLaMF4C9A/lV9Fs
         x17weECbn9EgNYIuz2iENArQ5gSd5pYvJaxm8NiZ7Bq/CP+5Yh7hgEJtaF+cNSN5Y0tt
         E87C0elU8IK/rppRrzLWUv/iP5yMPXA8T3KY8OlxzGJPrYbQTeP0WPCgK4Er2unQJZmL
         QTuvEwokylyIVWrHL+jGCj8RQ8+pu7EkU8JD5tdp52UTMHu18Mex++EcmA5KjfPQcgxc
         2Iyw==
X-Gm-Message-State: APjAAAV83+o1cFEemdzE+kIu6wqGBE6LlM4J+OdKjmsRvFSNl3Sbi4ZS
        EnNdrsMZdvhYHLnaPqiELP1dZQ==
X-Google-Smtp-Source: APXvYqxTcOeKakVkVnRfDKB1sEvVry5SidNNAA2MWQss03LCkkiMkN7HRPpSFVMnOe5Jy+0NFihqiA==
X-Received: by 2002:a50:a495:: with SMTP id w21mr13800142edb.78.1557524027343;
        Fri, 10 May 2019 14:33:47 -0700 (PDT)
Received: from google.com ([2a00:79e0:1b:201:ee0a:cce3:df40:3ac5])
        by smtp.gmail.com with ESMTPSA id 65sm1685486edm.60.2019.05.10.14.33.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 14:33:46 -0700 (PDT)
Date:   Fri, 10 May 2019 23:33:40 +0200
From:   Jann Horn <jannh@google.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     viro@zeniv.linux.org.uk, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com,
        arnd@arndb.de, rob@landley.net, james.w.mcmechan@gmail.com
Subject: Re: [PATCH v2 3/3] initramfs: introduce do_readxattrs()
Message-ID: <20190510213340.GE253532@google.com>
References: <20190509112420.15671-1-roberto.sassu@huawei.com>
 <20190509112420.15671-4-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509112420.15671-4-roberto.sassu@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 09, 2019 at 01:24:20PM +0200, Roberto Sassu wrote:
> This patch adds support for an alternative method to add xattrs to files in
> the rootfs filesystem. Instead of extracting them directly from the ram
> disk image, they are extracted from a regular file called .xattr-list, that
> can be added by any ram disk generator available today.
[...]
> +struct path_hdr {
> +	char p_size[10]; /* total size including p_size field */
> +	char p_data[];  /* <path>\0<xattrs> */
> +};
> +
> +static int __init do_readxattrs(void)
> +{
> +	struct path_hdr hdr;
> +	char str[sizeof(hdr.p_size) + 1];
> +	unsigned long file_entry_size;
> +	size_t size, name_buf_size, total_size;
> +	struct kstat st;
> +	int ret, fd;
> +
> +	ret = vfs_lstat(XATTR_LIST_FILENAME, &st);
> +	if (ret < 0)
> +		return ret;
> +
> +	total_size = st.size;
> +
> +	fd = ksys_open(XATTR_LIST_FILENAME, O_RDONLY, 0);
> +	if (fd < 0)
> +		return fd;
> +
> +	while (total_size) {
> +		size = ksys_read(fd, (char *)&hdr, sizeof(hdr));
[...]
> +	ksys_close(fd);
> +
> +	if (ret < 0)
> +		error("Unable to parse xattrs");
> +
> +	return ret;
> +}

Please use something like filp_open()+kernel_read()+fput() instead of
ksys_open()+ksys_read()+ksys_close(). I understand that some of the init
code needs to use the syscall wrappers because no equivalent VFS
functions are available, but please use the VFS functions when that's
easy to do.
