Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7D8501F49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 01:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347751AbiDNXoa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Apr 2022 19:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347746AbiDNXo2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Apr 2022 19:44:28 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D50A9D079
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Apr 2022 16:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649979721; x=1681515721;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=octI8gkuUdPp2CcD7y3vKEWC/6kqL3X5ZcA2TURCbbY=;
  b=gX3+tS6s+1C222edG0DtU7aXkr+B9G7cSjeEt0TfkRdqB9WgEWS1VVIh
   iEBfxFNQ3yecMPePyRYXw/5ReemVrx412NPPmyo7AzZ6LofzRjkDJEca6
   LfK7vhjT65TOA51hqb1bHMW5gqHUzlF7py427dJgr+/7+/VpubYDeExvz
   mQFvyOZlI5GmE1BBGRxrM9x0pglEYYXRxTCVoR1EKAnySeGGH2r/xzXhU
   t34rXpipio578S2m6n5XNGDDBBSDRWbMZmj0Qf4hTLv7q4bPDotfcjxmh
   fv2deNZuklckVXDU8jF1uwQXPV3RZ/vj6TahtMIPriv9FPWFAs2cvTj0b
   g==;
X-IronPort-AV: E=Sophos;i="5.90,261,1643644800"; 
   d="scan'208";a="309920055"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2022 07:42:01 +0800
IronPort-SDR: 6LShydgYuG8UIx/+LtCHAh/dRbQfJL6fEyQtOSt2lNdwa7mplqScAf+k8rVw5vx71zl7FRQqZ9
 8qRmSZRUlS9FHHvDNAxv1KlBwnmC/NGfx5zwfcsIvFkj9ap/w+MbyMk3vSkIB30Cff66wXdXwS
 jjhGUs8MtkHAQ8UfmbaHGIPkFqjxzHok+IvlYcktA6WQ6vod92Dvk3X3zgrDQG+W1Fw8PtTi3P
 s5W1pLkt6+5exRjGFB9ta6KDxXjQm8TJnz6afDYRZPcdDLN4G+v0Iruzqsv8bqKNTPRypj6BzT
 zVMsb6+HQlX+GF/pQuxblIOm
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Apr 2022 16:12:26 -0700
IronPort-SDR: +z00QgUge2qK8cPIVkln77Bh1vOHeyaNqG0XJWhzufQ9YiiC0DX7CxTnMeoihn2sq3J1ySGpQA
 1zKfTRSqWuNs9RnqesVKsMxa0hbdovFHd3OXGISLIsQF9XFpV8KcYLPsxeaVzmDIl3IVU7cQmC
 dNWctyYKmcnzgvH0H49Eyi4Yb0+I8H23xHbDmAzeEyWr3HOzJNs3VtrNrUu2Mq7EbFhAWiXtdh
 6pkkK7bLePLS8D5mlSSqPSD66fjqtW1wq+r8sy7Sti4OtfcxOVh8Xwucciw1Xglc8dpf7oX9YK
 iFI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Apr 2022 16:42:01 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KfbbD6pk3z1SVp1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Apr 2022 16:42:00 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649979720; x=1652571721; bh=octI8gkuUdPp2CcD7y3vKEWC/6kqL3X5ZcA
        2TURCbbY=; b=G8u3sp4M11CSasP2r1AQLolHkzCU61yyv5FwdwwXq4CypIYTAnH
        hGyML2VTo37SlnJ9Mgk5XyJhd01IXY5KeJdsnBN8iKFe3L71ueTUYRYA1dKm/Q3h
        OeieM9OwF+JDY+JUsMXV7vBYzylsEK9jEj5n//hIieuSziiWR7dUOgd1xX6WlwZD
        miasY8fSj3Q7K7nemKO99tJ3LrlcOpZK3FpOM6uBS7pT6Ly3pq4NCCFEggimhqFg
        1oOm7TyQJrpQ8icbEc176i79M8XmZw+lTmLadQG9q9348w3MXGxYfLM4MSQ94Zv8
        NsVkd07JhCSjOYZN5yR6fQdvhg/eLTFYX+A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8CfLSzcjjzXc for <linux-fsdevel@vger.kernel.org>;
        Thu, 14 Apr 2022 16:42:00 -0700 (PDT)
Received: from [10.225.163.9] (unknown [10.225.163.9])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KfbbB0qm4z1Rvlx;
        Thu, 14 Apr 2022 16:41:57 -0700 (PDT)
Message-ID: <04a0c48d-e81f-264a-b467-4a5b3ffc4f9c@opensource.wdc.com>
Date:   Fri, 15 Apr 2022 08:41:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] binfmt_flat: do not stop relocating GOT entries
 prematurely on riscv
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Mike Frysinger <vapier@gentoo.org>, stable@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org
References: <20220414091018.896737-1-niklas.cassel@wdc.com>
 <202204141624.6689D6B@keescook>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202204141624.6689D6B@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/15/22 08:27, Kees Cook wrote:
> On Thu, Apr 14, 2022 at 11:10:18AM +0200, Niklas Cassel wrote:
>> bFLT binaries are usually created using elf2flt.
>> [...]
>=20
> Hm, something in the chain broke DKIM, but I can't see what:
>=20
>   =E2=9C=97 [PATCH v2] binfmt_flat: do not stop relocating GOT entries =
prematurely on riscv
>     =E2=9C=97 BADSIG: DKIM/wdc.com

Hu... WDC emails are not spams :)
No clue what is going on here. I can check with our IT if they changed
something though.

>=20
> Konstantin, do you have a process for debugging these? I don't see the
> "normal" stuff that breaks DKIM (i.e. a trailing mailing list footer, e=
tc)
>=20


--=20
Damien Le Moal
Western Digital Research
