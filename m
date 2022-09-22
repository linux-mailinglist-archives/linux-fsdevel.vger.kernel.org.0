Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132A05E6858
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 18:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiIVQ1W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 12:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiIVQ1U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:27:20 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11BC2B189
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 09:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663864039; bh=HLuQousOxe85ItzKBGOzCJooyd+X6tRLuu1h8Oz3VYg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Zqz1L2qMONfJcSjF+NbdkK0DCKmzBNKVSX+1s14XCgM+lLq5QKG3f2FGrR9YU0YaUIWePnfxDpm8ceiS6XJPJXWTBcmvK8NtWZ1w1SM7v4HwQHvpLa09AXeKv401EOZpUmgzTUdJr4mgNgU+SVATVDVDrhiJBPhE/Re/9J4hSiUdH0Q4Z/oJwPUfvguLWE5hNBJU6GwPtTIzrJW765m/iK2gXgLhxf1pFljRe1Ina+RSTK1UJxolsAtBb0RHZ5xwal5XUxs1ZJQ9M6sLx12pDouNaTlJSyDjLUaGixxF0SQ4u1DRSSSvvzQdj4V1aOCTf5st59ehBO6+LE7dVwZwBg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663864039; bh=Mlvi4DG+D4A+V6g6owYVyZXrfPAkdABSrMXJAPp2biz=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=t//XGhUd91Hs6DOar9xOjvR1nZVph9eTWdIfX1b9vnEJTPTFgVhze2Tscdk4mhHq3xaXYvhe1g+NUL6xqDeeFitVuqk6oQc8t8l7GJu46ngcD42mpOFtjb0jLH0FdRSOqALDDC/usS3/FwywzPUwurWWfbT2+LcmlbWLWEc5AJPIE1LR442ahRI6fZQFs8dePurk2ZvSEXvKufk2II/3U2E4PUWShEONJMKtLLjPIsa3/jG2LQVDBBkI+noU5/1RQD0nXxg45zrg899+WU/f+ypkUfsPI+veGid4yE+1qsEHlsFbXb5zjdb0ABs+Ab5GkwM6Tgn48QIKSKxgrt/Gmw==
X-YMail-OSG: f5ydc9QVM1k7l1ohbr0jcrv8Un_EBpkKiqfkcN1GW_4p2A5EoNiwnZqiq2Gahix
 tIfkYa2DOehcBuyYAwgsjrioDTGPCpagtmSQ2HNOqqq5vH3jGzjKkjW3XyXuz07fdGxRLVKh3bLg
 aQhdHshX.G4R3h3Zh1HTcjs.B4BMb8U9WSFf5_SU0aAPQtC1tSwhqNyE5c3O3UwfhoAirGEG.7cC
 pkJqhHWJf.s1J09eC3XNLeg18kn3yXN3ZBTF3JNwr4dtgJak9l9f0LGKYtN1uiLj8hjKt13t9vCZ
 jSSyh0ry_pI9tYXN5.nJlIXjAAKn01Ma7idTpgKRSN5OReHlkoKh6CxcPoptMFDWUYMzcsN7O1Ql
 IhLkVvl_WnFVpx7awaPtO_ILCl9EYxCwMiiZIrBDKstze9kuEujQq3U8t3JwirU5N47kusx70O6C
 N6VH5rc6S8eWusPTqN1Dj_sH9XsxvtYWV3gxR7yTL4rZH.grFVvqrt0iEe.TlLypS_x1e_k0vYok
 op4blUDGKCPwbXsE6hlClgDy28AYa42poGZoHHsmZSTKopAg7QPqSw5gwnDP7ZFFZO8IijbOWKJh
 3daYLhnHp.aTT190DGZq81OggjA7aWJSO1ArH5xMZcKFHFr7FTq39_SL2YftUDNBFoshl9xZsN1p
 7jpa0RRtkL99457X97Y35Co.12Ca394JZLTfCOO93qzWJjRa150NmzXKU7oAgKTIgkSpYdfZ7tJI
 TBR4AyYqDx7CPvknwaED5fpSyX8CqzDknnSwAPMgbm3mWEprjz5yAo_f.m2IVUeDFnPxnjbnA_YV
 1KiSm3qxb0WRwfkqTpenCHG.5qpLK8nYa4jgLf.o.maFjWqx0TDSM_nLnPb_2gHKE3zpAP4ffS3y
 57G7D5sEnKmeUQr6Tt1.yozx_.kJCKB_H70ObOyNQ0E4xOwdZyiRsjevl3t_f4CYfwnXcnyieuDd
 rydogEf6aRLtATGNqp2iziCIY.Jug0I9Gaa0dK_.SE5cYzUgqHIDWjvO4rZdrq2.KU5yNANYgsG2
 d4POCv5x9TGi_toDam3vlfqgljywx0gmJiCcGKEDp.M0iyToPySKn7RObpAse2t5cc8NJDYaaO2P
 pWi7j5N_mZwwWYnBVpcyJWpCr4J5DLjRhPsjEJkPJ1smYdKq7ZDfZ0E1ZOKRwOnE3BfFf_pfFZ7O
 jOwvXiwLQK4ihhu4669.NifzP2vLzfrvN0eSfMU2b5GjMbsOuu7gd8iLfoieNgCnvIcWIECGb29T
 BUCosGkL_NeIw_ahIgMNwVXUTaOBPtZtZJsXCjfywgj4Q25BaS1qahrlGkVgGfnMGDlr5WAGuRW0
 N8IhuuCuSxY.SdjMdVlhlHO9ADB1TR6RVpoyCqCW2Qb4j3_amERC6Pfq0YGGpwJm_IcKejb67QHV
 fF3L5LAxR8yQ.vs1ewfoMJ_vQN3rY0.ffCNwk9KdmmtY5fBF1jpECEeWYgnhSu4XGcSt0BEuFqPj
 ZBImzjTWj5x.kkDMBaa4s3hTYXplWLiR5hfH8VCUBGWShxNfd1LZ.nJA9L6QJm_6WFbKEc88qNoV
 JBioltqYz_U5ut92wwGvmu7AI6RFYB89Pg7saJm.h9Sye88F_NtM38mN3Kaa5LBnOZyBCrsax5L1
 ANY.df7R61EdyKopPbuBdvvNQzd_hh41NhjED01_IOzbK978uK9x9aDG2RHbTFxBJ4F_EGPUBFL8
 BnCWLZyo8XMtTeToI8E36mNSBMj_xU.ICEaoKv.u3f2SJMh_7hMHc1BxpMEb5gNCe4Z9sbiMe6.x
 kfqa.Pn2kzrP4gjQ1UGpWNBTTUqn180V7dKMrC7T2.tLI0Gd3c1I0tUhPx7JulMrCKhXzzH_0_wq
 2CPUripjjJSX_e2ojdt3baExHLhw7QmFjcrFU71tHkjne1m8gcH494dewy0tPxoIZyKaYYbkShH6
 SKIJ9TNPuloXeFvQpSPlpvcYudPKbZLP8l3CvxuAs7ZJ9nom.m_BWr_1WqCTeWDDmvGlh9X6.g6W
 M6BQOZo1uJXAEAHA7Nc6riHhUXup_yjSPDI26AISc4TwmfABtlFcFJndJxO7aRJQRcnsf5K0W8ei
 ELJti6viwuAdDtJ7gULm1Mmrg6QFjHvkHzQoC2Eh3a8b0gZXPzijVe3Rfp1sQI0hE20X6RxmLJzs
 uetAlHe_kGU7Jb97icngcoJH4.A1UbSdw7UML2gaQ9.dt8zNBA4Qy19EPRW2k6Ww59S8wIw0I5ox
 ahmLcH580L4vuppt2g9tBxo78_IZkPAb89JvbE8U6rGFEcGhkcZ1Pf9o5fzM5lt8GQkXDAcRGy0N
 RIOtdITdM73m0aeRTJ15YgDopgQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 Sep 2022 16:27:19 +0000
Received: by hermes--production-bf1-64b498bbdd-ds6cg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 803b97668af2e2870df2ffe80b36b598;
          Thu, 22 Sep 2022 16:27:13 +0000 (UTC)
Message-ID: <d74030ae-4b9a-5b39-c203-4b813decd9eb@schaufler-ca.com>
Date:   Thu, 22 Sep 2022 09:27:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 00/29] acl: add vfs posix acl api
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, casey@schaufler-ca.com
References: <20220922151728.1557914-1-brauner@kernel.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220922151728.1557914-1-brauner@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20663 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/22/2022 8:16 AM, Christian Brauner wrote:
> From: "Christian Brauner (Microsoft)" <brauner@kernel.org>

Could we please see the entire patch set on the LSM list?
( linux-security-module@vger.kernel.org )
It's really tough to judge the importance of adding a new
LSM hook without seeing both how it is called and how the
security modules are expected to fulfill it. In particular,
it is important to see how a posix acl is different from
any other xattr. 

