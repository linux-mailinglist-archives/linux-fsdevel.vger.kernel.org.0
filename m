Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9937145A5A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 15:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbhKWObK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 09:31:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235177AbhKWObK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:31:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54B1D60E54;
        Tue, 23 Nov 2021 14:28:00 +0000 (UTC)
Date:   Tue, 23 Nov 2021 15:27:57 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hfsplus: Use struct_group_attr() for memcpy() region
Message-ID: <20211123142757.khjhbeqdo5byqae7@wittgenstein>
References: <20211119192851.1046717-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211119192851.1046717-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 19, 2021 at 11:28:51AM -0800, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memset(), avoid intentionally writing across
> neighboring fields.
> 
> Add struct_group() to mark the "info" region (containing struct DInfo
> and struct DXInfo structs) in struct hfsplus_cat_folder and struct
> hfsplus_cat_file that are written into directly, so the compiler can
> correctly reason about the expected size of the writes.
> 
> "pahole" shows no size nor member offset changes to struct
> hfsplus_cat_folder nor struct hfsplus_cat_file.  "objdump -d" shows no
> object code changes.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Looks good.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
