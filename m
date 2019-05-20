Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6371022CB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 09:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbfETHK6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 03:10:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:41020 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729518AbfETHK5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 03:10:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56767AD5C;
        Mon, 20 May 2019 07:10:56 +0000 (UTC)
Date:   Mon, 20 May 2019 09:10:55 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        dmitry.kasatkin@gmail.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH V3 1/6] VFS: Add a call to obtain a file's hash
Message-ID: <20190520071055.GB4985@x250>
References: <20190517212448.14256-1-matthewgarrett@google.com>
 <20190517212448.14256-2-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190517212448.14256-2-matthewgarrett@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 17, 2019 at 02:24:43PM -0700, Matthew Garrett wrote:
> + * vfs_gethash - obtain a file's hash
[...]
> +int vfs_get_hash(struct file *file, enum hash_algo hash, uint8_t *buf,

Nit: the kernel-doc says it's called vfs_gethash(), but the function is called
vfs_get_hash().
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
