Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A559244C48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Aug 2020 17:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgHNPov (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Aug 2020 11:44:51 -0400
Received: from sonic302-27.consmr.mail.ne1.yahoo.com ([66.163.186.153]:43562
        "EHLO sonic302-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbgHNPou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Aug 2020 11:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597419889; bh=ljMTuwKrqWkkWYdOmTtthmbN/XW+/rs+OF/GwBjGrBw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=ErpnedFsPZRbMGEsJw200Lp0vuzgd1/boPU1Rv+jwRb2wxSEC8ikJ5OThfSO10tR/S32c9QJbLg4y940/5xeUebxB474e6BA42w0CYFVFbLTqZ3B+N26Hn7JF3eBjpz5TQXH9q3ySFFQ+syK+1k6kv2VJ4ziJ9UnI8xT1SdkJ0GTMj2MZyLNZFjwxhyEuHF2aajeKHL3q11/W5fyaJcQSbKnABo+2Kekb8C2Ir1ADdSby+T5LBzfT32HezLFRgQl68O+2NvzAZIT6e9FLBmKDXyh8JCjMMEMARgAyOxs80LnGBWRELnEzpWhIzUIuccCbWeIBCRtJ2VYJkhtHlZ2qw==
X-YMail-OSG: xA0MxCcVM1mRxT2g.XuvwZrozYnabCC57fe3kjrBynO.K9BFv8zAVnlX198W4lz
 b5dlK6ZZ4KxOsAiybM3VX99A9Mpx1iiYPo7np8mM2H0aVY9Va7yXc7jT.xQXaEGqLSKZLYCO504I
 ssslaRLAUp5p6S4kUiLCTr5tIXt.L54.U29jMFQitytVqJXLwD45IahJUclkbkxaik.EuM_2.TPG
 YeK5Wmbz_gnwXOEVICOOnNrTWc0zTNlul3KgU4eyCw6wOVV4Q4OLe_S1c.Y3.4Qe6fIs0ghW2fSq
 A6CWeNU7r_RneNHXohSqJjJAx1LURp_WwR0h8c_qMXZN1vLUE8F5q4ukH8Egx3zeSCkwB08UXPoc
 qVxYBXV0tqq8hd6PPC.v5wGBd4N3yMzvzl6PMC0dQBLSpK_qHhakUQHIiKqBx1_2gsG7uDAjHAQT
 kMf3aOmFngHxXZbSefrXV0SSufDbOSf3XorkhuNFA7X9kA_3UaWdNm3rTlYJPC082Pi8WxxBzo5W
 c0AdUFJknDuFw_jiSkYaOLTFYToEsxaHaN.Q_etSVkK3aZuCIUZKjR0_DBQSg_r3bNdE1CYyHQHd
 kjILf4AQOn.vgQt8W7E8MTqOFENOOokSGL3ZMwipzKdb9iZs1z6veXgdSRMPpMuPx5lGJGX1po10
 ndr6siUCWb7rRaSA8QRoMRCIY.qXCVUMYR7FZIvfVu1tpDsgPdYKnwiNxBFJUpMfBg6SS6OUIWfh
 WKP6dktrhdF_FVW8lpc.uJVhUj4qCf49.ZaOszSrfbiZbNbbhcVP7Hbyn1K.dWdLYNcCMEF1w3ZI
 a8r4rQa3yuaKZHjaGz3_vv_TkLyzIAfKHi61RqPGWgxr4Qsr7OofeGrYYs5Jxby1rsxPMS2xcQAd
 RhAt.HVSKi1Ku94UpEvtY5e32gF0pm1oa.n117gCw9nI1v.JjllcZeiuKIKCsx1uUV3qnsE0HaHJ
 A4lybxdlQvKUGBqGXcPpixrijMsmWinDdOw9X1PNlHlEVFG5da_yHczwROJ6an41zcZWzZR4xIyA
 BhE0GN8nXel0UAnfUKuYb1uHFRBVMs2_Dalqcp0oCGMSbHfws6W8bLqznTiNVXZEouSflFA1aszt
 pl9nnGFzYNC4bIuknXbnYnqIfrBmDjSoqiXHHebfOlzXBMDxmWfFEzkypB.9PqDHCZgnanhzbh82
 ifxsFRHcZS13.UYYS35gHbE1_rArMFsztvgGRPkYfo2Xltpqna_IKb8MQnRY_EhuVGqpC.eiywQ8
 b8pShJvR_6QiDKde6JEQMAyTOxvDd51177u1aTrcgp5q8rdRlLPmHigl_Bd80DK.FB3iauBcrXb.
 mNnHbdnqeeQmARNc2RLO4gzTv58J7O3orz5TjGy54eplMTb5O_WcDqC7deKaCq5Fkz0CEJrrBQzC
 nFSvRJff5.Do4rm.8LLUdqRdzhEyUf3p6XE6n16DUZBTnai2HpgH_H_SbPjvlq.IcIYyIpi6vJP9
 v9EuJcTv_KJ9g
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 14 Aug 2020 15:44:49 +0000
Received: by smtp418.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 6f53f5395e5d6d626ec2c1ba3b2dcae2;
          Fri, 14 Aug 2020 15:44:49 +0000 (UTC)
Subject: Re: [RESEND] [PATCHv4 1/2] uapi: fuse: Add FUSE_SECURITY_CTX
To:     Chirantan Ekbote <chirantan@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        SElinux list <selinux@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200722090758.3221812-1-chirantan@chromium.org>
 <CAJFHJrr+B=xszNvdkmksG5ULPy_nKpn4_MS9_Pnq6ySkkb5y6g@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <1dfa1ae5-bb5a-67ea-f38a-b9d9a545dd0a@schaufler-ca.com>
Date:   Fri, 14 Aug 2020 08:44:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJFHJrr+B=xszNvdkmksG5ULPy_nKpn4_MS9_Pnq6ySkkb5y6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16455 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/13/2020 10:20 PM, Chirantan Ekbote wrote:
> On Wed, Jul 22, 2020 at 6:09 PM Chirantan Ekbote <chirantan@chromium.org> wrote:
>> Add the FUSE_SECURITY_CTX flag for the `flags` field of the
>> fuse_init_out struct.  When this flag is set the kernel will append the
>> security context for a newly created inode to the request (create,
>> mkdir, mknod, and symlink).  The server is responsible for ensuring that
>> the inode appears atomically with the requested security context.
>>
>> For example, if the server is backed by a "real" linux file system then
>> it can write the security context value to
>> /proc/thread-self/attr/fscreate before making the syscall to create the
>> inode.
>>
> Friendly ping. Will this (and the next patch in the series) be merged into 5.9?

This really needed to go to the LSM List <linux-security-module@vger.kernel.org>.


>
> Chirantan
>
>
> Chirantan
