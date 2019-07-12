Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 307146743F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 19:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfGLRdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 13:33:03 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52310 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfGLRdD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 13:33:03 -0400
Received: by linux.microsoft.com (Postfix, from userid 1029)
        id B8E2F20B7185; Fri, 12 Jul 2019 10:33:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by linux.microsoft.com (Postfix) with ESMTP id B512A300790D;
        Fri, 12 Jul 2019 10:33:02 -0700 (PDT)
Date:   Fri, 12 Jul 2019 10:33:02 -0700 (PDT)
From:   Jaskaran Singh Khurana <jaskarankhurana@linux.microsoft.com>
X-X-Sender: jaskarankhurana@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net
To:     gmazyland@gmail.com
cc:     ebiggers@google.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, jmorris@namei.org,
        Scott Shell <SCOTTSH@microsoft.com>,
        Nazmus Sakib <mdsakib@microsoft.com>, mpatocka@redhat.com
Subject: Re: [RFC PATCH v6 0/1] Add dm verity root hash pkcs7 sig
 validation.
In-Reply-To: <MN2PR21MB12008A962D4DD8662B3614508AF20@MN2PR21MB1200.namprd21.prod.outlook.com>
Message-ID: <alpine.LRH.2.21.1907121025510.66082@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.inter>
References: <20190701181958.6493-1-jaskarankhurana@linux.microsoft.com> <MN2PR21MB12008A962D4DD8662B3614508AF20@MN2PR21MB1200.namprd21.prod.outlook.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hello Milan,

> Changes in v6:
>
> Address comments from Milan Broz and Eric Biggers on v5.
>
> -Keep the verification code under config DM_VERITY_VERIFY_ROOTHASH_SIG.
>
> -Change the command line parameter to requires_signatures(bool) which will
> force root hash to be signed and trusted if specified.
>
> -Fix the signature not being present in verity_status. Merged the
> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fmbroz%2Flinux.git%2Fcommit%2F%3Fh%3Ddm-cryptsetup%26id%3Da26c10806f5257e255b6a436713127e762935ad3&amp;data=02%7C01%7CJaskaran.Khurana%40microsoft.com%7C18f92445e46940aeebb008d6fe50c610%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636976020210890638&amp;sdata=aY0V9%2FBz2RHryIvoftGKUGnyPp9Fsc1JY4FZbHfW4hg%3D&amp;reserved=0
> made by Milan Broz and tested it.
>
>

Could you please provide feedback on this v6 version.

Regards,
Jaskaran
