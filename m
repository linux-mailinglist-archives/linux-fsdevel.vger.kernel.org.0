Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 182D33C36F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 07:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391144AbfFKFcM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 01:32:12 -0400
Received: from namei.org ([65.99.196.166]:38356 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390492AbfFKFcM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 01:32:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5B5VjUm008646;
        Tue, 11 Jun 2019 05:31:45 GMT
Date:   Tue, 11 Jun 2019 15:31:45 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Milan Broz <gmazyland@gmail.com>
cc:     Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, scottsh@microsoft.com, ebiggers@google.com,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [RFC PATCH v3 1/1] Add dm verity root hash pkcs7 sig
 validation
In-Reply-To: <54170d18-31c7-463d-10b5-9af8b666df0f@gmail.com>
Message-ID: <alpine.LRH.2.21.1906111524060.8305@namei.org>
References: <20190607223140.16979-1-jaskarankhurana@linux.microsoft.com> <20190607223140.16979-2-jaskarankhurana@linux.microsoft.com> <54170d18-31c7-463d-10b5-9af8b666df0f@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 8 Jun 2019, Milan Broz wrote:

> > Adds DM_VERITY_VERIFY_ROOTHASH_SIG_FORCE: roothash signature *must* be
> > specified for all dm verity volumes and verification must succeed prior
> > to creation of device mapper block device.
> 
> AFAIK there are tools that use dm-verity internally (some container
> functions in systemd can recognize and check dm-verity partitions) and with
> this option we will just kill possibility to use it without signature.
> 
> Anyway, this is up to Mike and Mikulas, I guess generic distros will not
> set this option.

Right, I think this option would not be for a general purpose distro, but 
for embedded systems and other cases where the user may want a more 
tightly locked-down system.

-- 
James Morris
<jmorris@namei.org>

