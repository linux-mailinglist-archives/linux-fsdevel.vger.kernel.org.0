Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 822D61219A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 20:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfLPTCj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 14:02:39 -0500
Received: from namei.org ([65.99.196.166]:37828 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfLPTCi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 14:02:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id xBGJ295Y009899;
        Mon, 16 Dec 2019 19:02:09 GMT
Date:   Tue, 17 Dec 2019 06:02:09 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
cc:     gregkh@linuxfoundation.org, rafael@kernel.org, dhowells@redhat.com,
        matthewgarrett@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH v2] debugfs: Return -EPERM when locked down
In-Reply-To: <20191207161603.35907-1-eric.snowberg@oracle.com>
Message-ID: <alpine.LRH.2.21.1912170601440.7457@namei.org>
References: <20191207161603.35907-1-eric.snowberg@oracle.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 7 Dec 2019, Eric Snowberg wrote:

> When lockdown is enabled, debugfs_is_locked_down returns 1. It will then
> trigger the following:


Acked-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

