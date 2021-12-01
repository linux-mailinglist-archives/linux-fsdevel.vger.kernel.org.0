Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB2F465071
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 15:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbhLAOyl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 09:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhLAOyk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:54:40 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB0DC061574;
        Wed,  1 Dec 2021 06:51:19 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id A42816EAA; Wed,  1 Dec 2021 09:51:18 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org A42816EAA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1638370278;
        bh=hP3OqRp7KRlTbxxBWrk6JFRG0vTHLQh6UBhUgNJb/gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FdibrwTzgP+rgkXwjddKfZGAAkICYUfeOTH4PhHlVxwrRNq7lQuZPTZ8pEVmkMI2L
         KClJcwLmIHuvrWA+Avzi9JTz+p4TkaObbwcH7qyOgbRShTjTEGdh5kwzLLS+Fc/1ew
         MeGB0jG1YQISvSNy+4V+9JHOlkwKY4fnDm1M7H6A=
Date:   Wed, 1 Dec 2021 09:51:18 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20211201145118.GA26415@fieldses.org>
References: <da7394e0-26f6-b243-ce9a-d669e51c1a5e@oracle.com>
 <1285F7E2-5D5F-4971-9195-BA664CAFF65F@oracle.com>
 <e1093e42-2871-8810-de76-58d1ea357898@oracle.com>
 <C9C6AEC1-641C-4614-B149-5275EFF81C3D@oracle.com>
 <22000fe0-9b17-3d88-1730-c8704417cb92@oracle.com>
 <B42B0F9C-57E2-4F58-8DBD-277636B92607@oracle.com>
 <6f5a060d-17f6-ee46-6546-1217ac5dfa9c@oracle.com>
 <20211130153211.GB8837@fieldses.org>
 <f6a948a7-32d6-da9a-6808-9f2f77d5f792@oracle.com>
 <20211201143630.GB24991@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201143630.GB24991@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Do you have a public git tree with your latest patches?

--b.
