Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1A5189274
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 01:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbgCRAJb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 20:09:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35970 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgCRAJa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 20:09:30 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEMGz-00DtoA-Un; Wed, 18 Mar 2020 00:09:26 +0000
Date:   Wed, 18 Mar 2020 00:09:25 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] exfat: Simplify exfat_utf8_d_hash() for code points
 above U+FFFF
Message-ID: <20200318000925.GB23230@ZenIV.linux.org.uk>
References: <20200317222555.29974-1-pali@kernel.org>
 <20200317222555.29974-2-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200317222555.29974-2-pali@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 17, 2020 at 11:25:52PM +0100, Pali Rohár wrote:
> Function partial_name_hash() takes long type value into which can be stored
> one Unicode code point. Therefore conversion from UTF-32 to UTF-16 is not
> needed.

Hmm...  You might want to update the comment in stringhash.h...
