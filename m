Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E81640AFEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 15:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhINN6H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 09:58:07 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:42113
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233800AbhINN5r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 09:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1631627790; bh=ygtUBCZQlhsvVy8Mpq3cPYmpcsoXg4q8Q+Bm6VPv8k4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=UEHypIEim9VjqtsSFhyqQ/uCX1GPPf9LAeQIGOEVA3SZi5lSmDMB+qnIohAPxtB/jCxuIuSIlel0uvsao5GwR/nhRcvdgY1GGcHfuWN6Y22xCd2EGpEiobK5cvTW7Frp9xIPgLPHR/tTUlXlV76aA5RE85dPqcGGXVB2iH9PWp49PJLaJ+pIrNLV7aNgvMV/s+opH1yS2rgsuqeQs5wATILM02eRvAzrYmPQWXXR7LQwhF5oMKcS+/M2BWZ5ZozvyCu9Gp1chd4ilqIZezdv6AHU2wWQs+wP7Bh4rFeAMmFVe85AiR6gs6VHAKvqWkyOuxsOXgZo7X/wmEzgBhGTsQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1631627790; bh=tRp4urFM+77WkFz8lr06g8CaJlczUq+nX+CYQgOuq/o=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=ZElslV7oujTHYebxBiLhhX7uGLb3HacIYzYxCNEQuXbjL2Qb+nSpniignkUPscP45HiKdSF4I+D6MzJn9amezfKpeAqLQHf9UOzzvEJF33P9CwjuDzENXfaa6M7/O6CjRtewvVQbQaeFoIvfg6eKh+sRvobuy9bgs5XdOBwqDzvWf3sJYt/PMBWsrk+XRGLMRGRr2oGZjNpvp1iTtCoW/y/zELW+QFL5dW5svx9juE3+eZHT1G6SyZsktxbcyQy2NIn2rERcLEZEb3RjWwUyQyHtGBvgY/xhoXkx8M2xPSFDC/7Y5qcYYl4OcjMVaXcBUurG3WqbaPJEZj+HAAAiIA==
X-YMail-OSG: CihxQSoVM1mxWzBrqoaFrbDYWxEPccdaWLACxeJrVxqz80zwuRYSWfIJDP4tAyB
 XxJ3yB0geoGoeaUAJpKmNp6pmDzcxoz_uaycprJ_7X16KwnVvpzOu0ETLx6ke15kaAdf_cN9a.D8
 bNFU9OCHhLAVHTiBu_6S0_lYTzJJ1i6ZhQptSlMWK4GGBnTT7jTUmi4CbDo_zAxTKU4VkT6ROXuY
 d4mOQ2dd1Y_YzNB1sQjAQUUBqcPLvvcbdPXskcz7rIbyog1spu0FFSmWt8aq5LiDq5zzuwmcJcBp
 jR1GKTUX1DUkb4tndZwdSXtRtby5OBUk6S3J_fEkoBwvsLE..9fEDGq.G65UYjsvYrb1m9Dbj_JZ
 w4TuL.uxi8yYCSCqRdvMNlBPKtNte_T9P.unf8fJ904nMmIIdT.u52RyCF3_deVGhQR07LbppBC8
 hv3VDg6m37woasHHKPMTrtmfc5d0ktVV4KPrJlj40ZFoY_lKNRrWIrR9uBIhPrJxUF1d76wzbpL_
 JnpQzBArXNuReXlexA6eGQvx8Wv8cjzK5wyr4kPDpAFCELKtagFK0D_ULEpRVoXTRsGpnRncTXDP
 a83KJfj63_yfjRl_BUAXEhG32LpJb4bSbosQ3A19Lur9Ioc9o7YLDonFrNFZroMgePnkrPfyx8wT
 um090X0_tPeeG5HU6C7xNVPviSU.DEP05wdxySWXFzBWjVR48OoNqJhm5JazdcTSkaXcMCDQQ409
 dwJ.zai.s9_q_2p7N51kU9UJEmrO.TRQTVn8H232Yr_b0VC1XqjmmzRKeTJSiwwbqAZL5Q6ctu2p
 2O_fqAUY9A3bXBllXJQ9yA8sG34aPGzkM32Uam41TmvK.g4zFqXVkBSCPOz0o7RXvae3gdkzBO1l
 j6rgN_96cGwnNKOeLFhOfrVK9CahPx5Lb0LimF2tA8MzZvVwOgQdXSiNTU9JItsrgF48mlj3d4J6
 SCRIXi78NGmwQHvLbGITh7XNqYqExNPdoHk_CSxIoWOzswqssppfBFHhX3C0d9JNjEdaSEreUL2f
 kSHhT7esdmKh77ADSeSK3ihASkyFHLYH8vYcGmHiNvxNuP4QnrlqmlO7.JVxaB7w0pb71vV4yomg
 AHRa86o2wxERV0Hc__ii20497f8EnWYOR6pSKp2XOFWPHSx5rua7c.cPmw1ToGgrouNMsEVVcSEu
 2c.ORdDGPePXn5ggUVwjn.przlLmU6co.3s76sHLZM9kVwjMty4UIIMnhb.K2e5WKIy5BL7ylkU_
 k32GJqtzk67iya68p2n7WBShdDz5qrwpNQedRPbrE4qxPq3GhwY4GPMg0jkq6UvTEnAlD5hXTnPR
 g4JIauOWgBRES27Y.1rgd4hzYyk5tmvaU6gm.bHFnabGSb4gu6f1GEDSkgOmXjKz977FBPbs74YY
 brzTokSwBcHrOqXphkCRYfc8je15r6tSFS4wyr3APHvZIJswldp9wk630soWicCXB.sRf2lL63K4
 RJxXDDPSnMfG5pykgolBgZBwGOhuWwoayp4NEQ8EvAtITiSoxeoBKJbxDggDGH5xF4.hafcAIWGA
 U84rhJ3AAy4ZFvgzJ4azi6OStsdGiNMNdiJPWeGVoOtvideNKBvM88VA4n2vTM9aQPkmhheGlPv0
 gIqIVtlBBM22eOQ0KYjRmnr7tiHMG_e_oc4nXEYDeUm8uLTUafXc2ePiIiH64gIBuMO6LQH6il4l
 .K_qUHqjR1Ak1aUA91f7KgT6x6Xpr7ffyi9mrWS45IkLiRECeK.1IDc0tTLlidTPXJNxDIPQE_hk
 qz7_rdECg6cByy5c2fHKa8UBwXEaBbl3RaBO.qzwsJqy3pJ.at2YQef7zVrMR7efFsJZYqo03.0n
 gbwlg.YQwB90jswNtjHfAmC4ywkO2uL0ZNkgXMmHJkX.Wzu39anq5MCnSx.KBUnfjbpLMAUI8MOI
 wl_IKqy_NhRHkysGZPBW3fv1MbBaXTwXbgqnU8tByliMnKEPMEAWZP75pQi4Sy5Bpgs66OLCib2O
 HiCqy7eZHE12yAcvK33JwtZacEmF5yPLce8fHAvF1XDStdSxe1BEfyrg6UDAO9e3gnsoNtjFBQX3
 12pPQJbNGQCScZD6KRnlHUi2dqoMXtY.cfkJOnZDV5w0fxyI6vJtyljtv2Z9HerVQllC6nis0URP
 HO3JrE1qxckMopsnx153SlOilWWn8DaJGFqhmpb7DHv.sljfGfca9nAPI2jLbHVbYJ_TOJWzCvgU
 lBQP7L8HEonRPflWM1o6hvwv80zxxHAFXOxAXKjj99Gy3qAIGMy4Nh3J_FD9dE2oJ6z5i.lKIJbk
 dMf2Tqew-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 14 Sep 2021 13:56:30 +0000
Received: by kubenode538.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d0f522968cfd6c000107dac3c722feb3;
          Tue, 14 Sep 2021 13:56:27 +0000 (UTC)
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dwalsh@redhat.com, christian.brauner@ubuntu.com,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, tytso@mit.edu, miklos@szeredi.hu,
        gscrivan@redhat.com, bfields@redhat.com,
        stephen.smalley.work@gmail.com, agruenba@redhat.com,
        david@fromorbit.com, Casey Schaufler <casey@schaufler-ca.com>
References: <20210902152228.665959-1-vgoyal@redhat.com>
 <79dcd300-a441-cdba-e523-324733f892ca@schaufler-ca.com>
 <YTEEPZJ3kxWkcM9x@redhat.com> <YTENEAv6dw9QoYcY@redhat.com>
 <3bca47d0-747d-dd49-a03f-e0fa98eaa2f7@schaufler-ca.com>
 <YTEur7h6fe4xBJRb@redhat.com>
 <1f33e6ef-e896-09ef-43b1-6c5fac40ba5f@schaufler-ca.com>
 <YTYr4MgWnOgf/SWY@work-vm>
 <496e92bf-bf9e-a56b-bd73-3c1d0994a064@schaufler-ca.com>
 <YUCa6pWpr5cjCNrU@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <b52527f7-62bb-4d20-9faa-0a085a0ca7a2@schaufler-ca.com>
Date:   Tue, 14 Sep 2021 06:56:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUCa6pWpr5cjCNrU@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.19013 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/14/2021 5:51 AM, Vivek Goyal wrote:
> Sorry, I have to repeat this so many times because you are 
> completely ignoring this requirement saying users will get it
> wrong. 

And I keep repeating myself because you are still wrong.
Configuration won't fix the problem. Tools won't fix the
problem. Your scheme is broken. Don't do it.

