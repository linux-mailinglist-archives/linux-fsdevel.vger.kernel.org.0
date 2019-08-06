Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31DB982FE3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 12:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732494AbfHFKoF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 06:44:05 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53112 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731922AbfHFKoE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:44:04 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x76Ahfh3070961;
        Tue, 6 Aug 2019 19:43:41 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Tue, 06 Aug 2019 19:43:41 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x76AheAo070955
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 6 Aug 2019 19:43:41 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 02/10] vfs: syscall: Add move_mount(2) to move mounts
 around
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     John Johansen <john.johansen@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        linux-security-module@vger.kernel.org
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
 <155059611887.17079.12991580316407924257.stgit@warthog.procyon.org.uk>
 <c5b901ca-c243-bf80-91be-a794c4433415@I-love.SAKURA.ne.jp>
 <20190708131831.GT17978@ZenIV.linux.org.uk> <874l3wo3gq.fsf@xmission.com>
 <20190708180132.GU17978@ZenIV.linux.org.uk>
 <20190708202124.GX17978@ZenIV.linux.org.uk> <87pnmkhxoy.fsf@xmission.com>
 <5802b8b1-f734-1670-f83b-465eda133936@i-love.sakura.ne.jp>
 <1698ec76-f56c-1e65-2f11-318c0ed225bb@i-love.sakura.ne.jp>
 <e75d4a66-cfcf-2ce8-e82a-fdc80f01723d@canonical.com>
 <7eb7378e-2eb8-c1ba-4e1f-ea8f5611f42b@i-love.sakura.ne.jp>
Message-ID: <16ae946d-dbbe-9be9-9b22-866b3cd1cd7e@i-love.sakura.ne.jp>
Date:   Tue, 6 Aug 2019 19:43:36 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7eb7378e-2eb8-c1ba-4e1f-ea8f5611f42b@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This 5.2-stable/5.3 patch is stalling. Should I ask different route?

On 2019/07/23 22:45, Tetsuo Handa wrote:
> Al, will you send this patch to 5.3-rcX via vfs.git tree?
