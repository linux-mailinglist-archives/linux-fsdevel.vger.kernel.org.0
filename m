Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 439D118DBB0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Mar 2020 00:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgCTXTz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Mar 2020 19:19:55 -0400
Received: from ms.lwn.net ([45.79.88.28]:44096 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgCTXTz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:19:55 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D98212D6;
        Fri, 20 Mar 2020 23:19:53 +0000 (UTC)
Date:   Fri, 20 Mar 2020 17:19:52 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wang Wenhu <wenhu.wang@vivo.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jaskaran Singh <jaskaransingh7654321@gmail.com>,
        "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, kernel@vivo.com
Subject: Re: [PATCH v3,1/2] doc: zh_CN: index files in filesystems
 subdirectory
Message-ID: <20200320171952.5a00ed84@lwn.net>
In-Reply-To: <20200316110143.97848-1-wenhu.wang@vivo.com>
References: <20200315155258.91725-1-wenhu.wang@vivo.com>
        <20200316110143.97848-1-wenhu.wang@vivo.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 16 Mar 2020 04:01:31 -0700
Wang Wenhu <wenhu.wang@vivo.com> wrote:

> Add filesystems subdirectory into the table of Contents for zh_CN,
> all translations residing on it would be indexed conveniently.
> 
> Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> ---
> Changelog since v1:
>  - v2: added SPDX header
>  - v3: rm raw latex field in translations/zh_CN/filesystems/index.rst
>         for none compatibility test with Sphinx 1.7.9 or later.
>        Actually only Sphinx v1.6.7 avalible for me currently.
>        Reviewed-by labels added

Both patches applied, thanks.

jon
